{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Audio editor
    audacity

    # DAW
    ardour
    bitwig-studio4

    # Plugin hosts & managers
#    carla           # Plugin host and rack

    # Guitar amp simulators & effects
    guitarix        # GTK guitar amp simulator (the "gtk" you remember!)
    gxplugins-lv2   # Guitarix LV2 plugins
    rakarrack

    # Plugin suites
    calf            # Calf Studio Gear ("calif" you remember!)
    distrho-ports   # DISTRHO Plugin collection
    kapitonov-plugins-pack
    lsp-plugins     # Linux Studio Plugins (excellent quality)
    x42-plugins     # Professional effects collection
    zam-plugins     # Zamaudio plugins

    # Utilities
    qpwgraph        # Visual audio routing for PipeWire
    easyeffects     # Real-time audio effects

    # Tuner for guitar
    lingot
  ];
}