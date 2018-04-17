#!/bin/bash

set -euo pipefail

readonly BACKUP_FILE="undo-fix-shortcuts-$(date +%s%N).sh"
readonly KEYS=(
    "/org/gnome/desktop/wm/keybindings/toggle-shaded"
    "/org/gnome/settings-daemon/plugins/media-keys/screensaver"
    "/org/gnome/settings-daemon/plugins/media-keys/terminal"
    "/org/gnome/desktop/wm/keybindings/switch-to-workspace-down"
    "/org/gnome/desktop/wm/keybindings/switch-to-workspace-up"
    "/org/gnome/desktop/wm/keybindings/switch-to-workspace-left"
    "/org/gnome/desktop/wm/keybindings/switch-to-workspace-right"
    "/org/gnome/desktop/wm/keybindings/begin-move"
    "/org/gnome/desktop/wm/keybindings/begin-resize"
)
readonly DISABLED_VALUE="['disabled']"

reassign-hotkeys() {
    for key in "${KEYS[@]}"; do
        local value
        value=$(dconf read "$key")
        printf "dconf write \"%s\" \"%s\"\n" "$key" "$value"
        dconf write "$key" "$DISABLED_VALUE"
    done
}

reassign-hotkeys
