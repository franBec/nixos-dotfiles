{ pkgs, lib, ... }:
let
  videoPath = "/home/pollito/Videos/background.mp4";

  # Build Hidamari from source
  hidamari = pkgs.python3Packages.buildPythonApplication rec {
    pname = "hidamari";
    version = "2.1.1";

    src = pkgs.fetchFromGitHub {
      owner = "jeffshee";
      repo = "hidamari";
      rev = "v${version}";
      sha256 = "sha256-8xF/SJY6VdLfKcx8Nwrat5ZbWFLWG9nKcLFLXLFLrLY=";
    };

    propagatedBuildInputs = with pkgs.python3Packages; [
      pygobject3
      pkgs.gtk3
      pkgs.glib
      pkgs.gobject-introspection
    ];

    nativeBuildInputs = with pkgs; [
      wrapGAppsHook
      gobject-introspection
    ];

    buildInputs = with pkgs; [
      gtk3
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-ugly
      gst_all_1.gst-libav
    ];

    dontWrapGApps = true;

    preFixup = ''
      makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
    '';

    meta = with lib; {
      description = "Video wallpaper for Linux";
      homepage = "https://github.com/jeffshee/hidamari";
      license = licenses.gpl3;
      platforms = platforms.linux;
    };
  };

  startScript = pkgs.writeShellScriptBin "restart-background" ''
    #!${pkgs.bash}/bin/bash

    # Check if video exists
    if [ ! -f "${videoPath}" ]; then
      echo "Error: Video file not found at ${videoPath}"
      exit 1
    fi

    # Kill any existing instances
    echo "Stopping any existing background..."
    ${pkgs.procps}/bin/pkill -f hidamari 2>/dev/null || true

    sleep 1

    echo "Starting Hidamari animated background..."
    ${hidamari}/bin/hidamari "${videoPath}" --daemon &

    echo "Background started!"
  '';

  stopScript = pkgs.writeShellScriptBin "stop-background" ''
    #!${pkgs.bash}/bin/bash
    echo "Stopping animated background..."
    ${pkgs.procps}/bin/pkill -f hidamari 2>/dev/null || true
    echo "Background stopped."
  '';
in
{
  home.packages = [
    hidamari
    startScript
    stopScript
    pkgs.procps
  ];

  # Autostart (disabled by default - test first!)
  home.file.".config/autostart/hidamari-background.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Hidamari Animated Background
    Exec=${startScript}/bin/restart-background
    X-GNOME-Autostart-enabled=false
    NoDisplay=true
    Terminal=false
  '';
}