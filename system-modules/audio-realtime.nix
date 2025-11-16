{ config, pkgs, lib, ... }:

{
  # Increase locked memory limit for real-time audio
  security.pam.loginLimits = [
    { domain = "@audio"; type = "-"; item = "rtprio"; value = "99"; }
    { domain = "@audio"; type = "-"; item = "memlock"; value = "unlimited"; }
    { domain = "@audio"; type = "-"; item = "nice"; value = "-19"; }
  ];

  # Ensure user is in audio group (already done, but good to be explicit)
  users.users.pollito.extraGroups = [ "audio" ];
}