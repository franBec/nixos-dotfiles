{ config, pkgs, lib, ... }:

{
  # ZRAM: Compressed swap in RAM
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}