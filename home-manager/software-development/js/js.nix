{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs-slim_24
    pnpm
  ];
}