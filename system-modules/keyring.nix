{ config, pkgs, lib, ... }:

{
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.ly.enableGnomeKeyring = true;

  # Optional: GUI to manage keyring
  programs.seahorse.enable = true;
}