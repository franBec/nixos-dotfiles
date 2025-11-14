{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "nixos";
    nameservers = [
      "1.1.1.1"   # Cloudflare Primary
      "1.0.0.1"   # Cloudflare Secondary
      "8.8.8.8"   # Google DNS (as a backup check)
    ];
    networkmanager = {
        dns = "none"; # Tells networkmanager to only use nameservers static list
        enable = true;
    };
  };
}