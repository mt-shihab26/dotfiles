#!/usr/bin/env zsh

# Map this script to a key to toggle "tab mode" (ON and OFF), where all windows
# are placed inside one same (tabbed) group

## Collect some data about the environment #####################################

ACTIVEWINDOW_JSON=$(hyprctl activewindow -j)
CLIENTS_JSON=$(hyprctl clients -j)

ORIGINAL_WORKSPACE=$(echo $ACTIVEWINDOW_JSON | jq ".workspace.id")
ORIGINAL_WINDOW=$(echo $ACTIVEWINDOW_JSON | jq ".address" | sed 's:"::g')

WINDOWS_IN_GROUPS=$(echo $CLIENTS_JSON |
    jq ".[] | select(.workspace.id == $ORIGINAL_WORKSPACE) | 
                  select(.grouped != []) | .address" |
    sed 's:"::g')

WINDOWS_NOT_IN_GROUPS=$(echo $CLIENTS_JSON |
    jq ".[] | select(.workspace.id == $ORIGINAL_WORKSPACE) | 
                  select(.grouped == []) | .address" |
    sed 's:"::g')

## Remove all tab groups #######################################################

COMMAND=""
for w in $WINDOWS_IN_GROUPS; do
    COMMAND="$COMMAND dispatch focuswindow address:$w; "
    COMMAND="$COMMAND dispatch moveoutofgroup; "
done
! [ -z "$COMMAND" ] && hyprctl --batch "$COMMAND" >/dev/null

## If toggling ON, group all windows under one single group ####################

if ! [ -z "$WINDOWS_NOT_IN_GROUPS" ]; then

    # Toggle group mode in the original window
    #
    COMMAND="         dispatch focuswindow address:$ORIGINAL_WINDOW; "
    COMMAND="$COMMAND dispatch togglegroup" >/dev/null

    hyprctl --batch $COMMAND >/dev/null

    # Keep "merging" all other windows in all directions
    #
    for combo in u:d d:u l:r r:l; do

        direction=$(echo $combo | cut -d: -f1)
        opposite=$(echo $combo | cut -d: -f2)

        counter=0
        while true; do
            hyprctl dispatch movefocus $direction >/dev/null

            CURRENT_WINDOW=$(hyprctl activewindow -j |
                jq ".address" | sed 's:"::g')

            if [ $ORIGINAL_WINDOW == $CURRENT_WINDOW ]; then
                break
            fi

            COMMAND="         dispatch moveintogroup $opposite; "
            COMMAND="$COMMAND dispatch changegroupactive 1"

            hyprctl --batch $COMMAND >/dev/null

            # Security check, in case something goes terribly wrong
            #
            counter=$((counter + 1))
            [ $counter -gt 10 ] && break
        done
    done
fi

## Move focus back to the original window ######################33##############

hyprctl dispatch focuswindow address:$ORIGINAL_WINDOW >/dev/null
