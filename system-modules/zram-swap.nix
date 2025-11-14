{ config, pkgs, lib, ... }:

{
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}