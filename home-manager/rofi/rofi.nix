{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    rofi
  ];

  programs.rofi = {
    enable = true;
    
    theme = "${config.xdg.configHome}/rofi/catppuccin-default.rasi"; 

    extraConfig = {};
  };

  home.file.".config/rofi/catppuccin-default.rasi" = {
    source = ./catppuccin-default.rasi;
    target = ".config/rofi/catppuccin-default.rasi";
  };
  
  home.file.".config/rofi/catppuccin-mocha.rasi" = {
    source = ./catppuccin-mocha.rasi;
    target = ".config/rofi/catppuccin-mocha.rasi";
  };
}