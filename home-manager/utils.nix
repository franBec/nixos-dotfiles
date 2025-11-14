{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    sublime3
    toybox
    tree
    xclip
  ];

  programs.firefox.enable = true;  
}