{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./alacritty.toml);
  };

  home.file.".config/autostart/alacritty.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Alacritty
    Comment=Terminal emulator
    Exec=${pkgs.alacritty}/bin/alacritty
    Icon=Alacritty
    Terminal=false
    Categories=System;TerminalEmulator;
    StartupNotify=false
    X-GNOME-Autostart-enabled=true
  '';
}