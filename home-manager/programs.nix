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
  
  xdg.configFile."starship.toml".source = ./starship.toml; 
  
  home.file.".zshrc" = {
    source = ./zsh/.zshrc;
    recursive = false;
  };
}