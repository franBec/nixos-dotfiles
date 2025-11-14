{ config, pkgs, lib, ... }:

{
  # Accept NVIDIA license
  nixpkgs.config.nvidia.acceptLicense = true;

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

  # 3. CPU Performance Governor
  # Force performance mode for intel_pstate
  powerManagement.cpuFreqGovernor = lib.mkForce "performance";

  # 4. I/O Scheduler - use udev rules (modern approach)
  services.udev.extraRules = ''
    # Set kyber scheduler for rotating disks and SSDs
    ACTION=="add|change", KERNEL=="sd[a-z]|nvme[0-9]*", ATTR{queue/scheduler}="kyber"
  '';
}