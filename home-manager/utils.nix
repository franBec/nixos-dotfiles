{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    dnslookup
    nix-prefetch-github
    sublime3
    toybox
    tree
    xclip
  ];

  programs.firefox.enable = true;  
}