{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../system-modules/common.nix
    ];

  environment.systemPackages = with pkgs; [
    wget
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "Lenovo-ideapad-L340-15IRH";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  programs.dconf.enable = true;
  services.printing.enable = true;
  system.stateVersion = "25.05";
  time.timeZone = "Europe/Lisbon";
}
