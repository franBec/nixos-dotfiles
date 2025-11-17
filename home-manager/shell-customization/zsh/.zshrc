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

        printf "\nFILE: ~/nixos-dotfiles/flake.lock\n"
        cat ~/nixos-dotfiles/flake.lock 2>/dev/null || echo "(flake.lock not found or accessible)"

    ) > "$LOG_FILE"
    echo "Configuration data successfully exported to $LOG_FILE"
    echo "Use 'cat $LOG_FILE' or 'bat $LOG_FILE' to view."
}

lv2Info() {
    local LOG_FILE="$HOME/nixos-dotfiles/lv2-plugins-info.log"
    (
        printf "=== LV2 PLUGINS INFORMATION ===\n\n"

        printf "LV2_PATH:\n%s\n\n" "$LV2_PATH"

        printf "=== PLUGIN DIRECTORIES ===\n\n"
        for dir in $(echo $LV2_PATH | tr ':' '\n'); do
            if [ -d "$dir" ]; then
                printf "Directory: %s\n" "$dir"
                printf "Plugins:\n"
                ls -1 "$dir" | sed 's/^/  - /'
                printf "\n"
            fi
        done

        printf "\n=== ALL PLUGINS WITH NAMES ===\n\n"
        for dir in $(echo $LV2_PATH | tr ':' '\n'); do
            if [ -d "$dir" ]; then
                for plugin_bundle in "$dir"/*; do
                    if [ -d "$plugin_bundle" ]; then
                        bundle_name=$(basename "$plugin_bundle")
                        # Try to find the plugin name from TTL files
                        plugin_name=$(grep -hE '(rdfs:label|doap:name)' "$plugin_bundle"/*.ttl 2>/dev/null | \
                                     head -1 | \
                                     sed -E 's/.*["<]([^">]+)[">].*/\1/' | \
                                     tr -d '\n')

                        if [ -n "$plugin_name" ]; then
                            printf "%-50s | %s\n" "$bundle_name" "$plugin_name"
                        else
                            printf "%-50s | (name not found)\n" "$bundle_name"
                        fi
                    fi
                done
            fi
        done | sort

        printf "\n=== PLUGIN COUNT ===\n\n"
        total=$(for dir in $(echo $LV2_PATH | tr ':' '\n'); do
            if [ -d "$dir" ]; then
                ls -1d "$dir"/*/ 2>/dev/null
            fi
        done | wc -l)
        printf "Total LV2 plugins: %d\n" "$total"

    ) > "$LOG_FILE"
    echo "LV2 plugin data successfully exported to $LOG_FILE"
    echo "Use 'cat $LOG_FILE' or 'bat $LOG_FILE' to view."
}