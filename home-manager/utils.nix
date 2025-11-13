{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    sublime3
    tree
    xclip
  ];

  programs.firefox.enable = true;  
}