{ config, pkgs, ... }:

let
  # Modules following the ./something/something.nix pattern
  simpleModules = [
    "alacritty"
    "ani-cli"
    "audio-tools"
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
    ./performance-test/mesa-demos.nix
    ./jetbrains/webstorm.nix
    ./utils.nix
  ];
}