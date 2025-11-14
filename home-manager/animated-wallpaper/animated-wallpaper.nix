{ config, pkgs, ... }:
let
  scriptPath = ./start-animated-wallpaper.sh;
  deployedScript = "${config.home.homeDirectory}/.local/bin/start-animated-wallpaper.sh";
in
{
  home.packages = with pkgs; [
    mpv
    xdotool
    bash
  ];

  home.file.".local/bin/start-animated-wallpaper.sh" = {
    source = scriptPath;
    executable = true;
  };

  systemd.user.services.animated-wallpaper = {
    
    unitConfig = {
      Description = "MPV Animated Wallpaper Loop (from HM)";
    };
    
    wantedBy = {
      "graphical-session.target" = {};
    };

    serviceConfig = {
      ExecStart = deployedScript;
      Restart = "on-failure";
      Type = "simple";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2"; 
      Path = [ pkgs.xdotool pkgs.mpv pkgs.bash ]; 
    };
  };
}