{ config, pkgs, lib, ... }:

{
  # Disable power-profiles-daemon (it overrides CPU governor)
  services.power-profiles-daemon.enable = false;
  
  # Set CPU governor to performance mode
  systemd.services.cpu-governor-performance = {
    description = "Set CPU governor to performance mode";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/echo performance | ${pkgs.coreutils}/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'";
    };
  };
}