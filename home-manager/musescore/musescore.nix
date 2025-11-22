{ pkgs, ... }:
{
  home.packages = with pkgs; [
    appimage-run
  ];

  home.file.".local/share/icons/musescore.png".source = ./musescore.png;
  home.file.".local/share/applications/musescore-appimage.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=MuseScore 4
    Comment=Create, play and print beautiful sheet music
    Exec=${pkgs.appimage-run}/bin/appimage-run /home/pollito/Applications/MuseScore.AppImage %F
    Icon=/home/pollito/.local/share/icons/musescore.png
    Terminal=false
    Categories=AudioVideo;Audio;Music;
    MimeType=application/x-musescore;application/x-musescore+xml;
  '';
}