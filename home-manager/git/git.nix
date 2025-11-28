{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    extraConfig = {
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
    userName = "FranBec";
    userEmail = "franbecvort@gmail.com";
  };
}