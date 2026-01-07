{ pkgs, ... }:
{
  home.packages = with pkgs; [
    appimage-run
    bat
    busybox
    dnslookup
    fastfetch
    flameshot
    jq
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