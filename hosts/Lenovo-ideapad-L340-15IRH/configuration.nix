{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../system-modules/boot-loader.nix
      ../../system-modules/common.nix
      ../../system-modules/gamemode-steam.nix
      ../../system-modules/nvidia-geforce-gtx-1650.nix
      ../../system-modules/realtek-rtl8821ce-driver.nix
    ];

/*  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
    extraInstallCommands = ''
      echo "Not running bootctl update because ESP already has a newer system-boot."
    '';
  };*/
  networking.hostName = "Lenovo-ideapad-L340-15IRH";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  programs.dconf.enable = true;
  services.printing.enable = true;
  system.stateVersion = "25.05";
  time.timeZone = "Europe/Lisbon";
}
