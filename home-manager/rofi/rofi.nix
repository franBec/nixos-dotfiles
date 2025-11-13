{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    rofi
  ];

  programs.rofi = {
    enable = true;
    
    theme = "${config.xdg.configHome}/rofi/catppuccin-mocha.rasi"; 

    extraConfig = {
      modi = "drun,run";
    };
  };

  home.file.".config/rofi/catppuccin-mocha.rasi" = {
    source = ./catppuccin-mocha.rasi;
    target = ".config/rofi/catppuccin-mocha.rasi";
  };
}