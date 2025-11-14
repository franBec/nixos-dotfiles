{ pkgs, ... }:
let
  videoPath = "/home/pollito/Videos/background.mp4";

  xwinwrapScript = pkgs.writeShellScriptBin "restart-background" ''
    #!${pkgs.bash}/bin/bash

    # Check if video exists
    if [ ! -f "${videoPath}" ]; then
      echo "Error: Video file not found at ${videoPath}"
      exit 1
    fi

    # Kill any existing instances
    echo "Stopping any existing background..."
    ${pkgs.procps}/bin/pkill xwinwrap 2>/dev/null || true
    ${pkgs.procps}/bin/pkill -f "mpv.*background.mp4" 2>/dev/null || true

    sleep 1

    # Get the desktop window name for Cinnamon
    DESKTOP_WINDOW=$(${pkgs.xdotool}/bin/xdotool search --class "Nemo-desktop" | head -1)

    echo "Starting animated background..."
    # Key flags for Cinnamon:
    # -ov = override redirect (makes it part of desktop)
    # -ni = no input (click-through)
    # -st = skip taskbar
    # -sp = skip pager
    # -b = below other windows
    ${pkgs.xwinwrap}/bin/xwinwrap \
      -ov \
      -g 1920x1080 \
      -ni \
      -s \
      -st \
      -sp \
      -nf \
      -b \
      -- ${pkgs.mpv}/bin/mpv \
      --wid=WID \
      --loop \
      --no-audio \
      --no-osc \
      --no-osd-bar \
      --no-input-default-bindings \
      --no-stop-screensaver \
      --really-quiet \
      --panscan=1.0 \
      "${videoPath}" &

    echo "Background started. If you see a window, try disabling desktop icons in Cinnamon settings."
  '';

  stopScript = pkgs.writeShellScriptBin "stop-background" ''
    #!${pkgs.bash}/bin/bash
    echo "Stopping animated background..."
    ${pkgs.procps}/bin/pkill xwinwrap 2>/dev/null || true
    ${pkgs.procps}/bin/pkill -f "mpv.*background.mp4" 2>/dev/null || true
    echo "Background stopped."
  '';
in
{
  home.packages = with pkgs; [
    xwinwrap
    mpv
    procps
    xdotool
    xwinwrapScript
    stopScript
  ];

  # Autostart
  home.file.".config/autostart/xwinwrap-background.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Animated Background
    Exec=${xwinwrapScript}/bin/restart-background
    X-GNOME-Autostart-enabled=true
    NoDisplay=true
    Terminal=false
  '';
}