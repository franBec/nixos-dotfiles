{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
  ];

  # 1. Deploy the main configuration file
  home.file.".config/btop/btop.conf" = {
    source = ./btop.conf;
    target = ".config/btop/btop.conf";
  };

  # 2. Deploy the custom theme file to the required 'themes' subdirectory
  home.file.".config/btop/themes/Catppuccin-Mocha.theme" = {
    source = ./themes/Catppuccin-Mocha.theme;
    target = ".config/btop/themes/Catppuccin-Mocha.theme";
  };
}