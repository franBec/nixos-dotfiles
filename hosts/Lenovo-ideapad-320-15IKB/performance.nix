{ config, pkgs, lib, ... }:

{
  # 1. NVIDIA Hybrid Graphics Setup
  services.xserver.videoDrivers = [ "nvidia" ];

  # 940MX is a Maxwell GPU - use closed source drivers and possibly older version
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  hardware.nvidia.open = false;  # Use closed source drivers for older GPU

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