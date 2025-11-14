{ pkgs, ... }:
let
  videoPath = "/home/pollito/Videos/background.mp4";

  startScript = pkgs.writeShellScriptBin "start-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash

    # Kill existing
    pkill -f "mpv.*wallpaper"
    pkill -f "monitor-video-wallpaper"
    sleep 1

    # Disable Nemo desktop (it conflicts)
    gsettings set org.nemo.desktop show-desktop-icons false

    # Start mpv in background
    ${pkgs.mpv}/bin/mpv \
      --loop \
      --no-audio \
      --no-osc \
      --no-osd-bar \
      --no-input-default-bindings \
      --really-quiet \
      --geometry=1920x1080+0+0 \
      --no-border \
      --ontop=no \
      --no-keepaspect \
      --panscan=1.0 \
      --title="mpv-wallpaper" \
      --wid=0 \
      "${videoPath}" &

    MPV_PID=$!
    sleep 2

    # Get mpv window
    MPV_WINDOW=$(${pkgs.xdotool}/bin/xdotool search --pid $MPV_PID | head -1)

    if [ -n "$MPV_WINDOW" ]; then
      # Make it sticky and below
      ${pkgs.wmctrl}/bin/wmctrl -i -r $MPV_WINDOW -b add,sticky,below
      ${pkgs.wmctrl}/bin/wmctrl -i -r $MPV_WINDOW -b add,skip_taskbar,skip_pager
      ${pkgs.xdotool}/bin/xdotool windowmove $MPV_WINDOW 0 0
      ${pkgs.xdotool}/bin/xdotool windowlower $MPV_WINDOW

      echo "Video wallpaper started! Window ID: $MPV_WINDOW"

      # Start monitor in background
      ${monitorScript}/bin/monitor-video-wallpaper &
    else
      echo "Failed to find mpv window"
      exit 1
    fi
  '';

  monitorScript = pkgs.writeShellScriptBin "monitor-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash

    while true; do
      sleep 3

      # Check if mpv is still running
      if ! pgrep -f "mpv.*wallpaper" > /dev/null; then
        echo "MPV stopped, exiting monitor"
        exit 0
      fi

      # Find and lower the mpv window
      MPV_WINDOW=$(${pkgs.xdotool}/bin/xdotool search --name "mpv-wallpaper" 2>/dev/null | head -1)

      if [ -n "$MPV_WINDOW" ]; then
        # Keep it at the bottom
        ${pkgs.xdotool}/bin/xdotool windowlower $MPV_WINDOW 2>/dev/null
        ${pkgs.wmctrl}/bin/wmctrl -i -r $MPV_WINDOW -b add,below 2>/dev/null
      fi
    done
  '';

  stopScript = pkgs.writeShellScriptBin "stop-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash
    pkill -f "mpv.*wallpaper"
    pkill -f "monitor-video-wallpaper"

    # Re-enable desktop icons (optional)
    # gsettings set org.nemo.desktop show-desktop-icons true

    echo "Video wallpaper stopped"
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
    restoreDesktopScript
  ];

  home.file.".config/autostart/mpv-wallpaper.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=MPV Video Wallpaper
    Exec=${startScript}/bin/start-video-wallpaper
    X-GNOME-Autostart-enabled=true
    NoDisplay=true
    Terminal=false
  '';
}