{ pkgs, config, ... }:
let
  rofiConfigDir = "${config.xdg.configHome}/rofi";
in
{
  home.packages = with pkgs; [
    rofi
  ];

  programs.rofi = {
    enable = true;
    
    theme = "${rofiConfigDir}/launcher-t1-s5.rasi";

    extraConfig = {
      modi = "drun,run";
    };
  };

  # Layout file
  home.file.".config/rofi/launcher-t1-s5.rasi" = {
    source = ./launcher-t1-s5.rasi;
    target = "${rofiConfigDir}/launcher-t1-s5.rasi";
  };

  # The Palette
  home.file.".config/rofi/adapta-nokto.rasi" = {
    source = ./adapta-nokto.rasi;
    target = "${rofiConfigDir}/adapta-nokto.rasi";
  };

  # Colors mapping
  home.file.".config/rofi/shared/colors.rasi" = {
    source = ./shared/colors.rasi;
    target = "${rofiConfigDir}/shared/colors.rasi";
  };
}