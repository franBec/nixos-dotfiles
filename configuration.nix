{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "1.1.1.1"   # Cloudflare Primary
    "1.0.0.1"   # Cloudflare Secondary
    "8.8.8.8"   # Google DNS (as a backup check)
  ];
  networking.networkmanager.dns = "none"; # Tell NetworkManager to ignore DNS servers learned via DHCP/DHCPv6 and only use the static list defined above.

  time.timeZone = "Europe/Lisbon";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  security.rtkit.enable = true;

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "breeze"; 
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  home-manager.backupFileExtension = "backup";
  programs.zsh.enable = true;

  users.users.pollito = {
    isNormalUser = true;
    description = "pollito";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
    shell = pkgs.zsh; 

  };


  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
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