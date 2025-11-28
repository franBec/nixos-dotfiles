{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mangohud
  ];
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
}