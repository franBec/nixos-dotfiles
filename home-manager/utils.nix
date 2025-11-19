{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    busybox
    dnslookup
    nix-prefetch-github
    sublime3
    toybox
    tree
    xclip
    zip
  ];

  programs.firefox.enable = true;  
}