{ pkgs, ... }:
let
  # All plugin packages
  plugins = with pkgs; [
    calf
    distrho-ports
    gxplugins-lv2
    guitarix
    kapitonov-plugins-pack
    lsp-plugins
    x42-plugins
    zam-plugins
  ];

  # Build LV2_PATH from all plugin packages
  lv2Path = pkgs.lib.concatMapStringsSep ":" (pkg: "${pkg}/lib/lv2") plugins;
in
{
  home.packages = with pkgs; [
    ardour
    bitwig-studio
    easyeffects
    guitarix
    lingot
    rakarrack
#    musescore
    qpwgraph
  ] ++ plugins;

  # Set LV2_PATH to point directly to nix store plugin locations
  home.sessionVariables = {
    LV2_PATH = lv2Path;
  };
}