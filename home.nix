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
    };
    initExtra = ''
          freshfetch
          export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
          debuginfo() {
              local LOG_FILE="$HOME/nixos-debug-info.log"
              (
                  printf "SECTION: FRESHFETCH INFO\n"
                  freshfetch
                  printf "\nSECTION: CONFIGURATION.NIX (~/nixos-dotfiles/configuration.nix)\n"
                  cat ~/nixos-dotfiles/configuration.nix
                  printf "\nSECTION: FLAKE.NIX (~/nixos-dotfiles/flake.nix)\n"
                  cat ~/nixos-dotfiles/flake.nix
                  printf "\nSECTION: HOME.NIX (~/nixos-dotfiles/home.nix)\n"
                  cat ~/nixos-dotfiles/home.nix
              ) > "$LOG_FILE"
              echo "Configuration data successfully exported to $LOG_FILE"
              echo "Use 'cat $LOG_FILE' or 'bat $LOG_FILE' to view."
          }
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