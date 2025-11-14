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

    # Disable Nemo desktop first
    gsettings set org.nemo.desktop show-desktop-icons false
    sleep 1

    # Start mpv
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
      --cursor-autohide=always \
      "${videoPath}" &

    MPV_PID=$!
    echo "MPV started with PID: $MPV_PID"

    # Wait for window
    MPV_WINDOW=""
    for i in {1..20}; do
      sleep 0.5
      MPV_WINDOW=$(${pkgs.xdotool}/bin/xdotool search --pid $MPV_PID 2>/dev/null | head -1)
      if [ -n "$MPV_WINDOW" ]; then
        echo "Found MPV window: $MPV_WINDOW"
        break
      fi
    done

    if [ -z "$MPV_WINDOW" ]; then
      echo "ERROR: Failed to find mpv window"
      exit 1
    fi

    echo "Configuring window as desktop type..."

    # Set window type to desktop using xprop
    ${pkgs.xorg.xprop}/bin/xprop -id $MPV_WINDOW -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_DESKTOP

    # Additional window properties
    ${pkgs.xorg.xprop}/bin/xprop -id $MPV_WINDOW -f _NET_WM_STATE 32a -set _NET_WM_STATE _NET_WM_STATE_BELOW,_NET_WM_STATE_STICKY

    # Position and configure
    ${pkgs.xdotool}/bin/xdotool windowmove $MPV_WINDOW 0 0
    ${pkgs.xdotool}/bin/xdotool windowsize $MPV_WINDOW 1920 1080
    ${pkgs.wmctrl}/bin/wmctrl -i -r $MPV_WINDOW -b add,sticky,below,skip_taskbar,skip_pager
    ${pkgs.xdotool}/bin/xdotool windowlower $MPV_WINDOW

    # Make sure it stays below
    sleep 1
    ${pkgs.xdotool}/bin/xdotool windowlower $MPV_WINDOW

    echo "Video wallpaper started successfully!"

    # Start monitor
    ${monitorScript}/bin/monitor-video-wallpaper $MPV_WINDOW &
  '';

  monitorScript = pkgs.writeShellScriptBin "monitor-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash

    MPV_WINDOW=$1

    while true; do
      sleep 2

      if ! pgrep -f "mpv.*wallpaper" > /dev/null; then
        exit 0
      fi

      # Keep enforcing desktop type and below state
      ${pkgs.xorg.xprop}/bin/xprop -id $MPV_WINDOW -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_DESKTOP 2>/dev/null
      ${pkgs.xdotool}/bin/xdotool windowlower $MPV_WINDOW 2>/dev/null
      ${pkgs.wmctrl}/bin/wmctrl -i -r $MPV_WINDOW -b add,below,sticky 2>/dev/null
    done
  '';

  stopScript = pkgs.writeShellScriptBin "stop-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash
    pkill -f "mpv.*wallpaper"
    pkill -f "monitor-video-wallpaper"
    # Optionally restore desktop icons
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
    xorg.xprop
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