{ config, pkgs, lib, ... }:

{
  # 1. NVIDIA Hybrid Graphics Setup
  services.xserver.videoDrivers = [ "nvidia" ];

  # Note: Slightly older card (940MX) might sometimes need to use
  # `legacyPackages.390` or `legacyPackages.470` instead of `stable`,
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # NOTE: This setting makes the Intel GPU the primary display output.
  # You must use `prime-run` to launch applications on the NVIDIA card.
  services.xserver.prime.enable = true;

  # 2. Performance Tweaks (Memory/I/O)
  
  # ZRAM: Compressed swap in RAM
  services.zram.enable = true;
  services.zram.algorithm = "zstd";

  # Set default I/O scheduler via kernel parameters
  boot.kernelParams = [
    "elevator=kyber"
  ];

  # 3. CPU Performance Governor
  services.powerManagement.cpuFreqGovernor = "performance";
}