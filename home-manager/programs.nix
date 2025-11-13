{ pkgs, ... }:
{
  programs.firefox.enable = true;

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

  home.packages = with pkgs; [
    bat
    google-chrome
    htop
    nemo
    rofi
    sublime3
    sublime-merge
    tree
    xclip
  ];  
}