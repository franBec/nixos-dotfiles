{ config, pkgs, lib, ... }:

{
  # 1. NVIDIA Hybrid Graphics Setup
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.prime.enable = true;

  # 2. Performance Tweaks (Memory/I/O)
  
  # ZRAM: Compressed swap in RAM
  services.zram.enable = true;
  services.zram.algorithm = "zstd";

  # Set default I/O scheduler via kernel parameters
  # 'kyber' is a common choice for modern SSDs.
  boot.kernelParams = [
    "elevator=kyber"
  ];

  # 3. CPU Performance Governor
  services.cpupower.enable = true;
  services.cpupower.governor = "performance";
}