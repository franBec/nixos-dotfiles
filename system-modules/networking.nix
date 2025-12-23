{ config, pkgs, lib, ... }:
{
  networking = {
    nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];
    networkmanager = {
      dns = "none";
      enable = true;
      settings = {
        connectivity = {
          enabled = false;
        };
        device = {
          "wifi.scan-rand-mac-address" = true;
        };
        connection = {
          "wifi.cloned-mac-address" = "stable";
        };
      };
    };
  };
}