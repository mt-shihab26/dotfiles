#!/bin/bash

set -e

# undo: omarchy bar defaults

if [[ ! -d "$HOME/.config/omarchy/plugins/omarchy-orivo-plugin" ]]; then
  omarchy plugin add https://github.com/mt-shihab26/omarchy-orivo-plugin --yes
fi

omarchy plugin enable omarchy.indicators --section center --index 0
omarchy plugin enable omarchy-orivo-plugin --section center --after omarchy.indicators
omarchy plugin enable omarchy.clock --section center --after omarchy-orivo-plugin
omarchy plugin enable omarchy.weather --section center --after omarchy.clock 
omarchy plugin enable omarchy.keyboard-layout --section center --after omarchy.weather
omarchy plugin enable omarchy.microphone --section center --after omarchy.keyboard-layout
omarchy plugin enable omarchy.system-update --section center --after omarchy.microphone

omarchy bar set omarchy.clock format "ddd d MMM h:mm AP"
