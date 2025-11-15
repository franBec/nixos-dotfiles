{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    nix-prefetch-github
    sublime3
    toybox
    tree
    xclip
  ];

  programs.firefox.enable = true;  
}