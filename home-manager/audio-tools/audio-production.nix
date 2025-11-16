{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Audio editor
    audacity

    # DAW
    ardour

    # Plugin hosts & managers
#    carla           # Plugin host and rack

    # Guitar amp simulators & effects
    guitarix        # GTK guitar amp simulator (the "gtk" you remember!)
    gxplugins-lv2   # Guitarix LV2 plugins

    # Plugin suites
    calf            # Calf Studio Gear ("calif" you remember!)
    lsp-plugins     # Linux Studio Plugins (excellent quality)
    x42-plugins     # Professional effects collection

    # Additional useful plugins
    distrho-ports         # DISTRHO Plugin collection
    zam-plugins     # Zamaudio plugins

    # Utilities
    qpwgraph        # Visual audio routing for PipeWire
    easyeffects     # Real-time audio effects

    # Tuner for guitar
    guitaritone     # Guitar tuner
  ];
}