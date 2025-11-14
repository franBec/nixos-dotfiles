{ pkgs, ... }:
let
  videoPath = "/home/pollito/Videos/background.mp4";

  startScript = pkgs.writeShellScriptBin "start-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash

    # Kill existing
    pkill -f "mpv.*wallpaper"
    sleep 1

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
      "${videoPath}" &

    MPV_PID=$!
    sleep 2

    # Get mpv window and send to background
    MPV_WINDOW=$(${pkgs.xdotool}/bin/xdotool search --pid $MPV_PID | head -1)

    if [ -n "$MPV_WINDOW" ]; then
      # Make it sticky, below, and skip taskbar
      ${pkgs.wmctrl}/bin/wmctrl -i -r $MPV_WINDOW -b add,sticky,below
      ${pkgs.wmctrl}/bin/wmctrl -i -r $MPV_WINDOW -b add,skip_taskbar,skip_pager
      ${pkgs.xdotool}/bin/xdotool windowmove $MPV_WINDOW 0 0

      # Lower window to bottom
      ${pkgs.xdotool}/bin/xdotool windowlower $MPV_WINDOW

      echo "Video wallpaper started successfully!"
    else
      echo "Failed to find mpv window"
    fi
  '';

  stopScript = pkgs.writeShellScriptBin "stop-video-wallpaper" ''
    #!${pkgs.bash}/bin/bash
    pkill -f "mpv.*wallpaper"
    echo "Video wallpaper stopped"
  '';
in
{
  home.packages = with pkgs; [
    mpv
    xdotool
    wmctrl
    startScript
    stopScript
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