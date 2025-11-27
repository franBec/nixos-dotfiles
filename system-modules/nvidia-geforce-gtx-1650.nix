{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
   glxinfo
   vulkan-tools
   lm_sensors
  ];
  boot.kernelParams = [ "pcie_aspm=force" ];
  services.thermald.enable = true;
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