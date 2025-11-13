{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    rofi
  ];

  programs.rofi = {
    enable = true;
    
    extraConfig = {
      modi = "drun,run";
      theme = "${config.xdg.configHome}/rofi/catppuccin-mocha.rasi";
    };
  };

  home.file.".config/rofi/catppuccin-mocha.rasi" = {
    source = ./catppuccin-mocha.rasi;
    target = ".config/rofi/catppuccin-mocha.rasi";
  };
}