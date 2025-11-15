{ config, pkgs, lib, ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      bigclock = true;
      save_last_session = true;
    };
  };
}