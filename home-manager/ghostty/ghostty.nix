{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ghostty
  ];

  home.file.".config/ghostty/config.toml" = {
    source = ./config.toml;
    target = ".config/ghostty/config.toml";
  };

  home.file.".config/ghostty/themes/catppuccin-mocha.conf" = {
    source = ./themes/catppuccin-mocha.conf;
    target = ".config/ghostty/themes/catppuccin-mocha.conf";
  };
}