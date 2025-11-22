{ ... }:

{
  imports = [
    ./audio.nix
    ./audio-realtime.nix
    ./boot-loader.nix
    ./fonts.nix
    ./garbage-collecting.nix
    ./i18n.nix
    ./keyring.nix
    ./ly.nix
    ./networking.nix
    ./services-xserver.nix
    ./users.nix
  ];
}