#!/usr/bin/env zsh

# Toggle tab mode for all windows in the current workspace
# Works with Hyprland

## Collect workspace/window info ###############################################
ACTIVEWINDOW_JSON=$(hyprctl activewindow -j)
CLIENTS_JSON=$(hyprctl clients -j)

ORIGINAL_WORKSPACE=$(echo $ACTIVEWINDOW_JSON | jq ".workspace.id")
ORIGINAL_WINDOW=$(echo $ACTIVEWINDOW_JSON | jq -r ".address")

WINDOWS_IN_GROUPS=$(echo $CLIENTS_JSON |
    jq -r ".[] | select(.workspace.id == $ORIGINAL_WORKSPACE) | select(.grouped != []) | .address")

WINDOWS_NOT_IN_GROUPS=$(echo $CLIENTS_JSON |
    jq -r ".[] | select(.workspace.id == $ORIGINAL_WORKSPACE) | select(.grouped == []) | .address")

## Remove all tab groups (toggle OFF) ##########################################
if [ -n "$WINDOWS_IN_GROUPS" ]; then
    COMMAND=""
    for w in $WINDOWS_IN_GROUPS; do
        COMMAND="$COMMAND dispatch focuswindow address:$w; dispatch moveoutofgroup; "
    done
    hyprctl --batch "$COMMAND" >/dev/null
    exit 0
fi

## Toggle ON: group all windows into one tab group #############################
if [ -n "$WINDOWS_NOT_IN_GROUPS" ]; then
    # Start group mode on the original window
    hyprctl --batch "dispatch focuswindow address:$ORIGINAL_WINDOW; dispatch togglegroup" >/dev/null

    # Merge all other ungrouped windows into the group
    for w in $WINDOWS_NOT_IN_GROUPS; do
        [ "$w" = "$ORIGINAL_WINDOW" ] && continue
        hyprctl --batch "dispatch focuswindow address:$w; dispatch moveintogroup l" >/dev/null
    done
fi

## Return focus to the original window #########################################
hyprctl dispatch focuswindow address:$ORIGINAL_WINDOW >/dev/null
