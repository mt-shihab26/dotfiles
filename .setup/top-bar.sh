#!/bin/bash

set -e

# To undo this and restore the default bar layout: omarchy bar defaults

if [[ ! -d "$HOME/.config/omarchy/plugins/omarchy-orivo-plugin" ]]; then
  omarchy plugin add https://github.com/mt-shihab26/omarchy-orivo-plugin --yes
fi

# Enable (in case disabled) and move every widget into the center section, in
# this order: system-update, indicators, keyboard-layout, orivo-plugin,
# clock, microphone, weather.
omarchy plugin enable omarchy.system-update --section center --index 0
omarchy plugin enable omarchy.indicators --section center --after omarchy.system-update
omarchy plugin enable omarchy.keyboard-layout --section center --after omarchy.indicators
omarchy plugin enable omarchy-orivo-plugin --section center --after omarchy.keyboard-layout
omarchy plugin enable omarchy.clock --section center --after omarchy-orivo-plugin
omarchy plugin enable omarchy.microphone --section center --after omarchy.clock
omarchy plugin enable omarchy.weather --section center --after omarchy.microphone

omarchy bar set omarchy.clock format "ddd d MMM h:mm AP"
