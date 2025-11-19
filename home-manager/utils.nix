{ pkgs, ... }:
{
  home.packages = with pkgs; [
    appimage-run
    bat
    busybox
    dnslookup
    fastfetch
    nix-prefetch-github
    sublime3
    toybox
    tree
    xclip
    zip
  ];

  programs.firefox.enable = true;  
}