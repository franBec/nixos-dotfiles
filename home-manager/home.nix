{ config, pkgs, pkgs-unstable, ... }:

let
  # Modules following the ./something/something.nix pattern
  simpleModules = [
    "alacritty"
    "ani-cli"
    "btop"
    "google-chrome"
    "git"
    "komorebi"
    "rofi"
    "shell-customization"
    "ssh"
  ];

  simpleImports = map (name: ./${name}/${name}.nix) simpleModules;
in
{
  home.username = "pollito";
  home.homeDirectory = "/home/pollito";
  home.stateVersion = "25.05";

  imports = simpleImports ++ [
    ./audio-tools/audio-production.nix
    ./audio-tools/musescore/musescore.nix
    ./audio-tools/utils.nix
    ./performance-test/mesa-demos.nix
    ./software-development/gemini-cli.nix
    ./software-development/js.nix
    ./software-development/webstorm.nix
    ./utils.nix
  ];
}