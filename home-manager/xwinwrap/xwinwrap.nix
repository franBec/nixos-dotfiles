{ pkgs, ... }:
let
  videoPath = "/home/pollito/Videos/background.mp4";

  xwinwrapScript = pkgs.writeShellScript "start-xwinwrap" ''
    #!/usr/bin/env bash

    # Kill any existing instances
    ${pkgs.procps}/bin/pkill xwinwrap 2>/dev/null || true
    ${pkgs.procps}/bin/pkill -f "mpv.*background.mp4" 2>/dev/null || true

    sleep 2

    # Start xwinwrap with mpv - note: no --wid flag, xwinwrap handles it
    ${pkgs.xwinwrap}/bin/xwinwrap -g 1920x1080 -ov -ni -s -nf -b -- \
      ${pkgs.mpv}/bin/mpv \
        --loop=inf \
        --no-audio \
        --no-osc \
        --no-osd-bar \
        --no-input-default-bindings \
        --really-quiet \
        --panscan=1.0 \
        "${videoPath}" &
  '';

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
    procps
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
}