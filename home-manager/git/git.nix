{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "FranBec";
        email = "franbecvort@gmail.com";
      };
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}