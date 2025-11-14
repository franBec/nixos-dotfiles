{ pkgs, ... }:
let
  videoPath = "/home/pollito/Videos/background.mp4";

  startScript = pkgs.writeShellScriptBin "start-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash

    # Kill existing
    pkill -f "mpv.*wallpaper"
    pkill -f "monitor-video-wallpaper"
    sleep 1

    echo "Starting MPV..."

    # Start mpv with a unique class name
    ${pkgs.mpv}/bin/mpv \
      --loop \
      --no-audio \
      --no-osc \
      --no-osd-bar \
      --no-input-default-bindings \
      --really-quiet \
      --geometry=1920x1080+0+0 \
      --no-border \
      --no-keepaspect \
      --panscan=1.0 \
      --x11-name=mpv-wallpaper \
      --title=mpv-wallpaper \
      --force-window=immediate \
      "${videoPath}" &

    MPV_PID=$!
    echo "MPV started with PID: $MPV_PID"

    # Wait for window to appear (try for up to 10 seconds)
    MPV_WINDOW=""
    for i in {1..20}; do
      sleep 0.5

      # Try multiple search methods
      MPV_WINDOW=$(${pkgs.xdotool}/bin/xdotool search --class "mpv-wallpaper" 2>/dev/null | head -1)

      if [ -z "$MPV_WINDOW" ]; then
        MPV_WINDOW=$(${pkgs.xdotool}/bin/xdotool search --name "mpv-wallpaper" 2>/dev/null | head -1)
      fi

      if [ -z "$MPV_WINDOW" ]; then
        MPV_WINDOW=$(${pkgs.xdotool}/bin/xdotool search --pid $MPV_PID 2>/dev/null | head -1)
      fi

      if [ -n "$MPV_WINDOW" ]; then
        echo "Found MPV window: $MPV_WINDOW (attempt $i)"
        break
      fi

      echo "Waiting for window... (attempt $i/20)"
    done

    if [ -z "$MPV_WINDOW" ]; then
      echo "ERROR: Failed to find mpv window after 10 seconds"
      echo "Checking if mpv process is still running..."
      if ps -p $MPV_PID > /dev/null; then
        echo "MPV is running but window not detected"
        echo "All windows:"
        ${pkgs.xdotool}/bin/xdotool search --all --name "" 2>/dev/null | tail -10
      else
        echo "MPV process died. Check video file: ${videoPath}"
      fi
      exit 1
    fi

    echo "Configuring window..."

    # Disable Nemo desktop to prevent conflicts
    gsettings set org.nemo.desktop show-desktop-icons false

    # Configure the window
    ${pkgs.wmctrl}/bin/wmctrl -i -r $MPV_WINDOW -b add,sticky,below
    ${pkgs.wmctrl}/bin/wmctrl -i -r $MPV_WINDOW -b add,skip_taskbar,skip_pager
    ${pkgs.xdotool}/bin/xdotool windowmove $MPV_WINDOW 0 0
    ${pkgs.xdotool}/bin/xdotool windowlower $MPV_WINDOW

    echo "Video wallpaper started successfully!"
    echo "Window ID: $MPV_WINDOW"

    # Start monitor in background
    ${monitorScript}/bin/monitor-video-wallpaper $MPV_WINDOW &
    echo "Monitor started"
  '';

  monitorScript = pkgs.writeShellScriptBin "monitor-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash

    MPV_WINDOW=$1

    if [ -z "$MPV_WINDOW" ]; then
      echo "No window ID provided to monitor"
      exit 1
    fi

    echo "Monitoring window $MPV_WINDOW"

    while true; do
      sleep 2

      # Check if mpv is still running
      if ! pgrep -f "mpv.*wallpaper" > /dev/null; then
        echo "MPV stopped, exiting monitor"
        exit 0
      fi

      # Keep it at the bottom
      ${pkgs.xdotool}/bin/xdotool windowlower $MPV_WINDOW 2>/dev/null
      ${pkgs.wmctrl}/bin/wmctrl -i -r $MPV_WINDOW -b add,below 2>/dev/null
    done
  '';

  stopScript = pkgs.writeShellScriptBin "stop-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash
    echo "Stopping video wallpaper..."
    pkill -f "mpv.*wallpaper"
    pkill -f "monitor-video-wallpaper"
    echo "Video wallpaper stopped"
  '';

  debugScript = pkgs.writeShellScriptBin "debug-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash
    echo "=== Video Wallpaper Debug Info ==="
    echo ""
    echo "Video file: ${videoPath}"
    echo "File exists: $([ -f "${videoPath}" ] && echo "YES" || echo "NO")"
    echo ""
    echo "MPV processes:"
    ps aux | grep mpv | grep -v grep
    echo ""
    echo "MPV windows:"
    ${pkgs.xdotool}/bin/xdotool search --class mpv 2>/dev/null || echo "None found"
    echo ""
    echo "All recent windows:"
    ${pkgs.xdotool}/bin/xdotool search --all --name "" 2>/dev/null | tail -20
    echo ""
    echo "Testing MPV directly:"
    timeout 3 ${pkgs.mpv}/bin/mpv --version
  '';

  restoreDesktopScript = pkgs.writeShellScriptBin "restore-desktop-icons" ''
    #!${pkgs.bash}/bin/bash
    gsettings set org.nemo.desktop show-desktop-icons true
    echo "Desktop icons restored"
  '';
in
{
  home.packages = with pkgs; [
    mpv
    xdotool
    wmctrl
    startScript
    stopScript
    monitorScript
    debugScript
    restoreDesktopScript
  ];

  home.file.".config/autostart/mpv-wallpaper.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=MPV Video Wallpaper
    Exec=${startScript}/bin/start-video-wallpaper
    X-GNOME-Autostart-enabled=false
    NoDisplay=true
    Terminal=false
  '';
}