{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./alacritty.toml);
  };

  # Autostart Alacritty on login - left side, centered vertically
  home.file.".config/autostart/alacritty.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Alacritty
    Comment=Terminal emulator
    Exec=${pkgs.alacritty}/bin/alacritty --option window.dimensions.columns=120 --option window.dimensions.lines=35 --option window.position.x=50 --option window.position.y=220
    Icon=Alacritty
    Terminal=false
    Categories=System;TerminalEmulator;
    StartupNotify=false
    X-GNOME-Autostart-enabled=true
  '';
}