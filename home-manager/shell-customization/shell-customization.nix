{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch
    tree
  ];
  
  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
      ${builtins.readFile ./zsh/.zshrc}
    '';
  };
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}