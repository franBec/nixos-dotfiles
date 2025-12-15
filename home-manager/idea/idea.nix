{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    jetbrains.idea-community
  ];
}