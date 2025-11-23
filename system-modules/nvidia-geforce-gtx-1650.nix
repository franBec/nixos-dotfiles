{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.glxinfo
    pkgs.vulkan-tools
    pkgs.nvidia-settings
  ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      prime = {
        intelBusId  = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}