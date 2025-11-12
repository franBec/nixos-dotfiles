{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in

{
  home.username = "pollito";
  home.homeDirectory = "/home/pollito";
  home.stateVersion = "25.05";

  imports = [
    ./home-modules/multimedia.nix
  ];

  # -------------------------------------------------------------------
  # 1. Standard Dotfiles (Direct Symlinks to $HOME)
  # -------------------------------------------------------------------

  home.file = {
    ".zshrc" = {
      source = create_symlink "${dotfiles}/zsh/.zshrc";
      recursive = false;
    };
    ".gitconfig" = {
      source = create_symlink "${dotfiles}/git/.gitconfig";
      recursive = false;
    };
  };

  # -------------------------------------------------------------------
  # 2. XDG Configuration Files (Symlinks to ~/.config)
  # -------------------------------------------------------------------

  xdg.configFile = {
    alacritty = {
      source = create_symlink "${dotfiles}/alacritty";
      recursive = true;
    };
    "starship.toml" = {
      source = create_symlink "${dotfiles}/starship.toml";
      recursive = false;
    };
  };

  # -------------------------------------------------------------------
  # 3. Program Enables
  # -------------------------------------------------------------------

  programs.zsh.enable = true;
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  programs.firefox.enable = true;
  programs.git.enable = true;
  programs.starship.enable = true;
  programs.ssh = {
    enable = true;
    
    # Optional: Configure host-specific settings
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github_ed25519";
        forwardAgent = false;
      };
    };
  };

  # -------------------------------------------------------------------
  # 4. Packages
  # -------------------------------------------------------------------
  
  home.packages = with pkgs; [
    alacritty
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
  
}