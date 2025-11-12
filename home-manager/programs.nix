{ pkgs, ... }:
{
  
  programs.zsh.enable = true;
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  programs.firefox.enable = true;
  programs.starship.enable = true;
  
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github_ed25519";
        forwardAgent = false;
      };
    };
  };

  # Generic packages
  home.packages = with pkgs; [
    bat
    freshfetch
    google-chrome
    htop
    nemo
    rofi
    starship
    sublime3
    tree
    xclip
    zsh
  ];
  
  # Starship config is managed here if it doesn't need its own dedicated module folder
  xdg.configFile."starship.toml".source = ../../config/starship.toml; 
  
  # ZSH RC still needs to be symlinked/sourced (since it contains custom shell functions)
  home.file.".zshrc" = {
    source = ../../config/zsh/.zshrc;
    recursive = false;
  };
}