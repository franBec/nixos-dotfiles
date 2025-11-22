{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../system-modules/common.nix
      ../../system-modules/cpu-performance.nix
      ../../system-modules/io-scheduler.nix
      ../../system-modules/nvidia-geforce-940mx.nix
      ../../system-modules/zram-swap.nix
    ];

  environment.systemPackages = with pkgs; [
    wget
  ];
  networking.hostName = "Lenovo-ideapad-320-15IKB";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  programs.dconf.enable = true;
  services.printing.enable = true;
  system.stateVersion = "25.05";
  time.timeZone = "Europe/Lisbon";
}