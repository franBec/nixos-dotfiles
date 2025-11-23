{ config, pkgs, pkgs-unstable, ... }:

let
  # Modules following the ./something/something.nix pattern
  simpleModules = [
    "alacritty"
    "ani-cli"
    "audio-utils"
    "btop"
    "cinnamon-keybindings"
    "daw-and-lv2-plugins"
    "gemini-cli"
    "git"
    "google-chrome"
    "komorebi"
    "musescore"
    "nodejs"
    "pnpm"
    "rofi"
    "shell-customization"
    "ssh"
    "sublime3"
    "webstorm"
  ];

  simpleImports = map (name: ./${name}/${name}.nix) simpleModules;
in
{
  home.username = "pollito";
  home.homeDirectory = "/home/pollito";
  home.stateVersion = "25.05";

  imports = simpleImports ++ [
    ./utils.nix
  ];
}
