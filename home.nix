{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    alacritty = "alacritty";
  };
in

{
  home.username = "pollito";
  home.homeDirectory = "/home/pollito";
  home.stateVersion = "25.05";

  programs.zsh = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
    };
    initContent = ''
          freshfetch
          debuginfo() {
              local LOG_FILE="$HOME/nixos-debug-info.log"
              (
                  printf "SECTION: FRESHFETCH INFO\n"
                  freshfetch
                  printf "\nSECTION: SESSION TYPE\n"
                  echo "XDG_SESSION_TYPE: $XDG_SESSION_TYPE"
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
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  programs.firefox.enable = true;
  programs.git = {
    enable = true;
    userName = "FranBec";
    userEmail = "franbecvort@gmail.com";
  };
  programs.starship = {
    enable = true;
    settings = {
      format = "$username@$hostname $directory $character";
      username = {
        style_user = "bold blue";
        show_always = true;
      };
      hostname = {
        style = "bold blue";
      };
      directory = {
        style = "bold yellow";
      };
      character = {
        success_symbol = "[\\$](bold cyan)";
        error_symbol = "[\\$](bold red)";
      };
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    alacritty
    bat
    freshfetch
    google-chrome
    htop
    starship
    sublime3
    tree
    wl-clipboard
    zsh
  ];

}
