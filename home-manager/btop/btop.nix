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
  home.file.".config/btop/themes/Adapta-Nokto.theme" = {
    source = ./themes/Adapta-Nokto.theme;
    target = ".config/btop/themes/Adapta-Nokto.theme";
  };
}