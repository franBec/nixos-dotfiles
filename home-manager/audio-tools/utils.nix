{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alsa-utils
    pavucontrol      # PulseAudio/PipeWire volume control GUI
    qpwgraph         # PipeWire graph manager (like JACK patchbay)
    helvum           # Alternative PipeWire patchbay (simpler)
    easyeffects      # Audio effects (EQ, compressor, etc.)
  ];
}