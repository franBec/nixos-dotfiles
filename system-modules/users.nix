{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  users.users.pollito = {
    description = "pollito";
    extraGroups = [
      "networkmanager" # GUI Wifi management
      "wheel" # Sudo access
      "audio" # Required for the memory limit for real-time audio
    ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}