{ pkgs, ... }:
{
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    bat
    google-chrome
    sublime3
    tree
    xclip
  ];  
}