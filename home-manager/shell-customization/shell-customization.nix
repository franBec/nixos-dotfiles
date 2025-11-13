{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch
  ];
  
  programs.zsh.enable = true;
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
  home.file.".zshrc" = {
    text = ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
      ${builtins.readFile ./zsh/.zshrc}
    '';
    recursive = false;
  };

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}