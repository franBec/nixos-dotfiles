{ pkgs, ... }:
{
  home.packages = with pkgs; [
    webstorm
  ];
}