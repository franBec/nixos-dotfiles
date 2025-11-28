{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gamescope
  ];
  programs.gamemode.enable = true;
  programs.steam.gamescopeSession.enable = true;
}