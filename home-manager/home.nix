{ config, pkgs, pkgs-unstable, ... }:

let
  # Modules following the ./something/something.nix pattern
  simpleModules = [
    "alacritty"
    "ani-cli"
    "anydesk"
    "audio-utils"
    "btop"
    "daw-and-lv2-plugins"
    "gemini-cli"
    "git"
    "google-chrome"
    "idea"
    "java"
    "musescore"
    "nodejs"
    "opencode"
    "pnpm"
    "python"
    "rofi"
    "rofimoji"
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
