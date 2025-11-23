{ pkgs, ... }:
{
  home.packages = with pkgs; [
    appimage-run
    bat
    busybox
    dnslookup
    fastfetch
    flameshot
    mesa-demos
    nix-prefetch-github
    pciutils
    sublime3
    tree
    xclip
    zip
  ];

  programs.firefox.enable = true;  
}