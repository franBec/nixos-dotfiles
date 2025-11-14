{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../system-modules/audio.nix
      ../../system-modules/boot-loader.nix
      ../../system-modules/cpu-performance.nix
      ../../system-modules/fonts.nix
      ../../system-modules/garbage-collecting.nix
      ../../system-modules/i18n.nix
      ../../system-modules/io-scheduler.nix
      ../../system-modules/networking.nix
      ../../system-modules/nvidia.nix
      ../../system-modules/services-xserver.nix
      ../../system-modules/zram-swap.nix
    ];

  time.timeZone = "Europe/Lisbon";

  security.rtkit.enable = true;
  services.printing.enable = true;
  programs.dconf.enable = true;

  programs.zsh.enable = true;

  users.users.pollito = {
    isNormalUser = true;
    description = "pollito";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh; 
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";
}