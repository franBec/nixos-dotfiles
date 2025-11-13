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

  home.file.".config/rofi/launcher-t1-s5.rasi" = {
    source = ./launcher-t1-s5.rasi;
    target = "${rofiConfigDir}/launcher-t1-s5.rasi";
  };

  home.file.".config/rofi/catppuccin-mocha.rasi" = {
    source = ./catppuccin-mocha.rasi;
    target = "${rofiConfigDir}/catppuccin-mocha.rasi";
  };
  
  home.file.".config/rofi/shared/colors.rasi" = {
    source = ./shared/colors.rasi;
    target = "${rofiConfigDir}/shared/colors.rasi";
  };
}