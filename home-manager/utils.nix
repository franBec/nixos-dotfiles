{ pkgs, ... }:
{
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    bat
    google-chrome
    rofi
    sublime3
    tree
    xclip
  ];  
}