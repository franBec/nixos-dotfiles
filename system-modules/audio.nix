{ config, pkgs, lib, ... }:

{
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # Optional: Enable JACK support for professional audio
    jack.enable = true;
  };

  # Add user to audio group
  users.users.pollito.extraGroups = [ "audio" ];
}