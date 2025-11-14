{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mesa-demos
  ];
}