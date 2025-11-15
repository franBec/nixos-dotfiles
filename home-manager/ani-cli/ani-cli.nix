{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ani-cli
    mpv           # Video player
    aria2         # Download manager
    yt-dlp        # m3u8 Downloader
    ffmpeg        # m3u8 Downloader (fallback)
    fzf           # User interface
    # grep, sed, curl, patch are usually available by default in NixOS
  ];
}