{ config, pkgs, ... }:

{
  home.username = "pollito";
  home.homeDirectory = "/home/pollito";
  home.stateVersion = "25.05";

  imports = [
    ./alacritty/alacritty.nix
    ./btop/btop.nix
    ./google-chrome/google-chrome.nix
    ./git/git.nix
    ./performance-test/mesa-demos.nix
    ./rofi/rofi.nix
    ./shell-customization/shell-customization.nix
    ./ssh/ssh.nix
    ./jetbrains/webstorm.nix
    ./utils.nix
    ./xwinwrap/xwinwrap.nix
  ];
}