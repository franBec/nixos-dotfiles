{ config, pkgs, ... }:

{
  home.username = "pollito";
  home.homeDirectory = "/home/pollito";
  home.stateVersion = "25.05";

  imports = [
    ../../home-manager/alacritty/alacritty.nix
    ../../home-manager/btop/btop.nix
    ../../home-manager/git/git.nix
    ../../home-manager/ghostty/ghostty.nix
    ../../home-manager/shell-customization/shell-customization.nix
    ../../home-manager/ssh/ssh.nix
    ../../home-manager/utils.nix
  ];
}