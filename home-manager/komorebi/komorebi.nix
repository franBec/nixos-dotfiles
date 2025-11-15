{ pkgs, ... }:
{
  home.packages = with pkgs; [
    komorebi
  ];

  # Autostart Komorebi (disabled by default for testing)
  home.file.".config/autostart/komorebi.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Komorebi Animated Wallpaper
    Comment=Animated wallpaper manager
    Exec=${pkgs.komorebi}/bin/komorebi
    X-GNOME-Autostart-enabled=false
    NoDisplay=true
    Terminal=false
    Categories=System;
  '';
}