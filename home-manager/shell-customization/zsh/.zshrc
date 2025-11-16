alias nrs="sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos"
fastfetch
nixosInfo() {
    local LOG_FILE="$HOME/nixos-dotfiles/nixos-debug-info.log"
    (
        printf "SECTION: FASTFETCH INFO\n"
        fastfetch
        
        printf "\nSECTION: DOTFILES TREE (~/nixos-dotfiles)\n"
        tree ~/nixos-dotfiles -I ".git"
        
        printf "\nSECTION: DOTFILES CONTENT (All .nix files listed below)\n"
        find ~/nixos-dotfiles -type f -name '*.nix' -not -path '*/.git/*' | while read FILE_PATH; do
            printf "\nFILE: $FILE_PATH\n"
            cat "$FILE_PATH"
        done
        
        # Optionally, include flake.lock explicitly, as it's crucial for pinning
        printf "\nFILE: ~/nixos-dotfiles/flake.lock\n"
        cat ~/nixos-dotfiles/flake.lock 2>/dev/null || echo "(flake.lock not found or accessible)"

    ) > "$LOG_FILE"
    echo "Configuration data successfully exported to $LOG_FILE"
    echo "Use 'cat $LOG_FILE' or 'bat $LOG_FILE' to view."
}