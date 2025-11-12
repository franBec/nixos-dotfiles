{ pkgs, ... }:
{
  
  programs.zsh.enable = true;
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  programs.firefox.enable = true;
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
  
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
    sublime3
    tree
    xclip
    zsh
  ];
  
  home.file.".zshrc" = {
    text = ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
      ${builtins.readFile ./zsh/.zshrc}
    '';
    recursive = false;
  };
}