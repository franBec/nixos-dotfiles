{ config, pkgs, lib, ... }:

{
  # Set kyber I/O scheduler for better performance
  services.udev.extraRules = ''
    # Set kyber scheduler for rotating disks and SSDs
    ACTION=="add|change", KERNEL=="sd[a-z]|nvme[0-9]*", ATTR{queue/scheduler}="kyber"
  '';
}