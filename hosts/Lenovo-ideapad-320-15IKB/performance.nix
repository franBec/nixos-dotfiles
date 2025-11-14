{ config, pkgs, lib, ... }:

{
  # 1. NVIDIA Hybrid Graphics Setup
  # Enables NVIDIA drivers and PRIME (hybrid graphics switching)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.prime.enable = true;

  # 2. Performance Tweaks (Memory/I/O)
  
  # ZRAM: Compressed swap in RAM to prevent hard swaps to disk
  services.zram.enable = true;
  services.zram.algorithm = "zstd"; # ZSTD is generally faster than default LZO

  # Optional I/O Scheduler tweak for better disk latency (kyber is good for SSDs)
  boot.deviceTree.config = {
    "default_iosched" = "kyber";
  };

  # 3. CPU Performance Governor
  # Forces CPU to prioritize performance over power saving when running
  services.cpupower.enable = true;
  services.cpupower.governor = "performance";
}