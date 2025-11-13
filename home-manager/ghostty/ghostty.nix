{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ghostty
  ];

  home.file.".config/ghostty/config.toml" = {
    source = ./config.toml;
    target = ".config/ghostty/config.toml";
  };
}