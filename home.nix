{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {};
in

{
  home.username = "pollito";
  home.homeDirectory = "/home/pollito";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
      debuginfo = "( printf '\\n--- FRESHFETCH INFO ---\\n' && freshfetch && printf '\\n--- CONFIGURATION.NIX ---\\n' && cat ~/nixos-dotfiles/configuration.nix && printf '\\n--- FLAKE.NIX ---\\n' && cat ~/nixos-dotfiles/flake.nix && printf '\\n--- HOME.NIX ---\\n' && cat ~/nixos-dotfiles/home.nix ) | wl-copy";

    };
    initExtra = ''
          freshfetch
          export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
        '';
  };
  programs.firefox.enable = true;
  programs.git = {
    enable = true;
    userName = "FranBec";
    userEmail = "franbecvort@gmail.com";
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    bat
    freshfetch
    google-chrome
    htop
    ghostty
    rofi
    sublime3
    tree
    wl-clipboard
  ];

}