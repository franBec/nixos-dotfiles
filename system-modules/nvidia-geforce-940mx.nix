{ config, pkgs, lib, ... }:

{
  # Accept NVIDIA license
  nixpkgs.config.nvidia.acceptLicense = true;

  # NVIDIA Hybrid Graphics Setup
  services.xserver.videoDrivers = [ "nvidia" ];

  # 940MX is a Maxwell GPU - use closed source drivers
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    open = false;  # Use closed source drivers for older GPU
    modesetting.enable = true;

    # NVIDIA Prime Configuration - Offload Mode
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;  # Provides `nvidia-offload` command
      
      # Bus IDs from /sys/class/drm/
      intelBusId = "PCI:0:2:0";    # 0000:00:02.0
      nvidiaBusId = "PCI:1:0:0";   # 0000:01:00.0
    };
  };
}