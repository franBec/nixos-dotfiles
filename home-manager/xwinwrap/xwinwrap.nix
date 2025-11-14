{ pkgs, ... }:
let
  # Path to video
  videoPath = "/home/pollito/Videos/background.mp4";

  # xwinwrap script
  xwinwrapScript = pkgs.writeShellScript "start-xwinwrap" ''
    #!/usr/bin/env bash

    # Kill any existing xwinwrap instances
    ${pkgs.procps}/bin/pkill -f xwinwrap

    # Wait a moment for processes to terminate
    sleep 1

    # Get screen resolution
    SCREEN_WIDTH=$(${pkgs.xorg.xdpyinfo}/bin/xdpyinfo | ${pkgs.gnugrep}/bin/grep dimensions | ${pkgs.gawk}/bin/awk '{print $2}' | ${pkgs.coreutils}/bin/cut -d'x' -f1)
    SCREEN_HEIGHT=$(${pkgs.xorg.xdpyinfo}/bin/xdpyinfo | ${pkgs.gnugrep}/bin/grep dimensions | ${pkgs.gawk}/bin/awk '{print $2}' | ${pkgs.coreutils}/bin/cut -d'x' -f2)

    # Start xwinwrap with mpv
    ${pkgs.xwinwrap}/bin/xwinwrap -g "$SCREEN_WIDTH"x"$SCREEN_HEIGHT" -ov -ni -s -nf -b -- \
      ${pkgs.mpv}/bin/mpv \
        --loop \
        --no-audio \
        --no-osc \
        --no-osd-bar \
        --hwdec=auto \
        --vo=gpu \
        --wid=WID \
        --no-input-default-bindings \
        --no-stop-screensaver \
        "${videoPath}" &
  '';

  # Desktop entry for autostart
  xwinwrapAutostart = pkgs.makeDesktopItem {
    name = "xwinwrap-background";
    desktopName = "Animated Background";
    exec = "${xwinwrapScript}";
    icon = "video-display";
    type = "Application";
    noDisplay = true;
    terminal = false;
  };
in
{
  home.packages = with pkgs; [
    xwinwrap
    mpv
    xorg.xdpyinfo
  ];

  # Autostart entry
  home.file.".config/autostart/xwinwrap-background.desktop".source =
    "${xwinwrapAutostart}/share/applications/xwinwrap-background.desktop";

  # Script to manually restart the background
  home.file."bin/restart-background" = {
    text = ''
      #!/usr/bin/env bash
      ${xwinwrapScript}
    '';
    executable = true;
  };
}