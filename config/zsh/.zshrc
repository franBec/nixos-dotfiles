# This file is symlinked from home-manager

alias nrs="sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos"
freshfetch
debuginfo() {
    local LOG_FILE="$HOME/nixos-debug-info.log"
    (
        printf "SECTION: FRESHFETCH INFO\n"
        freshfetch
        printf "\nSECTION: SESSION TYPE\n"
        echo "XDG_SESSION_TYPE: $XDG_SESSION_TYPE"
        printf "\nSECTION: CONFIGURATION.NIX (~/nixos-dotfiles/configuration.nix)\n"
        cat ~/nixos-dotfiles/configuration.nix
        printf "\nSECTION: FLAKE.NIX (~/nixos-dotfiles/flake.nix)\n"
        cat ~/nixos-dotfiles/flake.nix
        printf "\nSECTION: HOME.NIX (~/nixos-dotfiles/home.nix)\n"
        cat ~/nixos-dotfiles/home.nix
    ) > "$LOG_FILE"
    echo "Configuration data successfully exported to $LOG_FILE"
    echo "Use 'cat $LOG_FILE' or 'bat $LOG_FILE' to view."
}