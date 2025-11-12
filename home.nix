{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in

{
  home.username = "pollito";
  home.homeDirectory = "/home/pollito";
  home.stateVersion = "25.05";

  # -------------------------------------------------------------------
  # 1. Standard Dotfiles (Direct Symlinks to $HOME)
  # -------------------------------------------------------------------

  home.file = {
    # Symlink ~/.zshrc to the external zsh configuration file
    ".zshrc" = {
      source = create_symlink "${dotfiles}/zsh/.zshrc";
      recursive = false;
    };
    # Symlink ~/.gitconfig to the external git configuration file
    ".gitconfig" = {
      source = create_symlink "${dotfiles}/git/.gitconfig";
      recursive = false;
    };
  };

  # -------------------------------------------------------------------
  # 2. XDG Configuration Files (Symlinks to ~/.config)
  # -------------------------------------------------------------------

  # Expanded xdg.configFile block for Alacritty and Starship
  xdg.configFile = {
    # Alacritty (Symlink ~/.config/alacritty/alacritty.toml)
    alacritty = {
      source = create_symlink "${dotfiles}/alacritty";
      recursive = true;
    };
    # Starship (Symlink ~/.config/starship.toml)
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

  # -------------------------------------------------------------------
  # 4. Packages
  # -------------------------------------------------------------------
  
  home.packages = with pkgs; [
    alacritty
    bat
    freshfetch
    gnome-terminal
    google-chrome
    htop
    nemo
    starship
    sublime3
    tree
    xclip
    zsh
  ];
  
}