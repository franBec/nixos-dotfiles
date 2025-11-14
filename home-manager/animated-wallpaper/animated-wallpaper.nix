{ config, pkgs, ... }:
let
  scriptPath = ./start-animated-wallpaper.sh;
  # Define the path where the script will be executable
  deployedScript = "${config.home.homeDirectory}/.local/bin/start-animated-wallpaper.sh";
in
{
  # Ensure necessary packages are installed
  home.packages = with pkgs; [
    mpv
    xdotool
    # Ensure bash is available for the script environment
    bash
  ];

  # Deploy the script to a place in the user's PATH (or easily referenced)
  home.file.".local/bin/start-animated-wallpaper.sh" = {
    source = scriptPath;
    executable = true;
  };

  # Set up the systemd user service
  systemd.user.services.animated-wallpaper = {
    description = "MPV Animated Wallpaper Loop (from HM)";
    # Start after the graphical session is ready
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      # The systemd service executes the deployed script
      ExecStart = deployedScript;
      Restart = "on-failure";
      Type = "simple";
      # Give the X server a moment to initialize before trying to find the root window
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2"; 
      # Ensure necessary utilities (like xdotool) are in the service environment PATH
      Path = [ pkgs.xdotool pkgs.mpv pkgs.bash ];
    };
  };
}