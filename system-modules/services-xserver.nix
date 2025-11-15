{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager.cinnamon.enable = true;
    xkb = {
      layout = "us,latam";
      options = "grp:win_space_toggle";
      variant = "";
    };
  };
}