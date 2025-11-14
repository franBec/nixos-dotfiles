{ pkgs, ... }:
let
  videoPath = "/home/pollito/Videos/background.mp4";

  xwinwrapScript = pkgs.writeShellScript "start-xwinwrap" ''
    #!/usr/bin/env bash

    # Wait for desktop to fully load
    sleep 5

    # Check if video file exists
    if [ ! -f "${videoPath}" ]; then
      echo "Video file not found: ${videoPath}"
      exit 1
    fi

    # Kill any existing instances
    ${pkgs.procps}/bin/pkill xwinwrap 2>/dev/null || true
    ${pkgs.procps}/bin/pkill -f "mpv.*background" 2>/dev/null || true

    sleep 1

    # Start xwinwrap with proper flags for background placement
    # Key changes:
    # -ov removed (was causing override issues)
    # -b keeps it at bottom
    # -d makes it a desktop window
    ${pkgs.xwinwrap}/bin/xwinwrap \
      -g 1920x1080 \
      -ni \
      -s \
      -nf \
      -b \
      -un \
      -argb \
      -fdt \
      -- ${pkgs.mpv}/bin/mpv \
        --loop=inf \
        --no-audio \
        --no-osc \
        --no-osd-bar \
        --no-input-default-bindings \
        --no-input-cursor \
        --no-terminal \
        --really-quiet \
        --vo=gpu \
        --hwdec=auto \
        --panscan=1.0 \
        "${videoPath}" &

    # Give it a moment to start
    sleep 2

    # Force the window to bottom (belt and suspenders approach)
    XWINWRAP_PID=$(${pkgs.procps}/bin/pgrep xwinwrap)
    if [ -n "$XWINWRAP_PID" ]; then
      ${pkgs.wmctrl}/bin/wmctrl -r "xwinwrap" -b add,below 2>/dev/null || true
    fi
  '';

  xwinwrapAutostart = pkgs.makeDesktopItem {
    name = "xwinwrap-background";
    desktopName = "Animated Background";
    exec = "${xwinwrapScript}";
    icon = "video-display";
    type = "Application";
    noDisplay = true;
    terminal = false;
    categories = [ "System" ];
  };
in
{
  home.packages = with pkgs; [
    xwinwrap
    mpv
    procps
    wmctrl
  ];

  home.file.".config/autostart/xwinwrap-background.desktop".source =
    "${xwinwrapAutostart}/share/applications/xwinwrap-background.desktop";

  home.file."bin/restart-background" = {
    text = ''
      #!/usr/bin/env bash
      ${xwinwrapScript}
    '';
    executable = true;
  };

  # Emergency stop script
  home.file."bin/stop-background" = {
    text = ''
      #!/usr/bin/env bash
      ${pkgs.procps}/bin/pkill xwinwrap
      ${pkgs.procps}/bin/pkill -f "mpv.*background"
      echo "Animated background stopped"
    '';
    executable = true;
  };
}