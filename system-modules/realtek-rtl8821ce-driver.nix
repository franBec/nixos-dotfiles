# https://github.com/tomaspinho/rtl8821ce
{ config, pkgs, lib, ... }:
{
  boot.kernelModules = [ "8821ce" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8821ce
  ];
}
