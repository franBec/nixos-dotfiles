# This file is symlinked from home-manager

alias nrs="sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos"

# Initializing shell environment
freshfetch

debuginfo() {
    local LOG_FILE="$HOME/nixos-debug-info.log"
    (
        printf "SECTION: FRESHFETCH INFO\n"
        freshfetch
        
        printf "\nSECTION: SESSION TYPE\n"
        echo "XDG_SESSION_TYPE: $XDG_SESSION_TYPE"
        
        printf "\nSECTION: DOTFILES TREE (~/nixos-dotfiles)\n"
        tree ~/nixos-dotfiles
        
        printf "\nSECTION: DOTFILES CONTENT (All files listed below)\n"
        
        # Use find to recursively locate all regular files
        find ~/nixos-dotfiles -type f | while read FILE_PATH; do
            # Exclude flake.lock from the content printout as it's often verbose and unnecessary
            if [[ "$FILE_PATH" != *"/flake.lock" ]]; then
                printf "\nFILE: $FILE_PATH\n"
                cat "$FILE_PATH"
            fi
        done
        
    ) > "$LOG_FILE"
    echo "Configuration data successfully exported to $LOG_FILE"
    echo "Use 'cat $LOG_FILE' or 'bat $LOG_FILE' to view."
}