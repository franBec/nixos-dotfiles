{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
  ];

  xdg.configFile.".gitconfig" = {
    source = ./.gitconfig;
    target = ".gitconfig";
  };
}