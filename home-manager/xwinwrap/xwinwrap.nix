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

    echo "Starting animated background..."
    # Use absolute paths and proper escaping
    exec ${pkgs.xwinwrap}/bin/xwinwrap \
      -g 1920x1080 \
      -ni \
      -s \
      -nf \
      -b \
      -- ${pkgs.mpv}/bin/mpv \
      --loop \
      --no-audio \
      --no-osc \
      --no-osd-bar \
      --no-input-default-bindings \
      --really-quiet \
      --panscan=1.0 \
      "${videoPath}"
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
    xwinwrapScript
    stopScript
  ];

  # Manual autostart file (only enable after testing)
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