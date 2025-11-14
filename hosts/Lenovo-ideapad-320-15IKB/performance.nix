{ config, pkgs, lib, ... }:

{
  # 1. NVIDIA Hybrid Graphics Setup
  services.xserver.videoDrivers = [ "nvidia" ];

  # Note: Slightly older card (940MX) might sometimes need to use
  # `legacyPackages.390` or `legacyPackages.470` instead of `stable`,
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # NVIDIA Prime Configuration
  hardware.nvidia.prime = {
    # Offload mode: Intel GPU is primary, use `nvidia-offload` for NVIDIA
    offload.enable = true;
    offload.enableOffloadCmd = true;  # Provides `nvidia-offload` command
    
    # Bus IDs from /sys/class/drm/
    intelBusId = "PCI:0:2:0";    # 0000:00:02.0
    nvidiaBusId = "PCI:1:0:0";   # 0000:01:00.0
  };

  hardware.nvidia.modesetting.enable = true;

  # 2. Performance Tweaks (Memory/I/O)
  
  # ZRAM: Compressed swap in RAM
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";

  # Set default I/O scheduler via kernel parameters
  boot.kernelParams = [
    "elevator=kyber"
  ];

  # 3. CPU Performance Governor
  powerManagement.cpuFreqGovernor = "performance";
}