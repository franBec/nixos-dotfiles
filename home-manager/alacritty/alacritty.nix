{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    alacritty
  ];

  xdg.configFile = {
    alacritty = {
      source = ./alacritty.toml;
      recursive = true;
    };
  };
}
