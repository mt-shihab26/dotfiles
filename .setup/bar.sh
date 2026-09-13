#!/bin/bash

set -e

# To undo this and restore the default bar layout: omarchy bar defaults
omarchy bar position bottom

if [[ ! -d "$HOME/.config/omarchy/plugins/omarchy-orivo-plugin" ]]; then
  omarchy plugin add https://github.com/mt-shihab26/omarchy-orivo-plugin --yes
fi

# Enable (in case disabled) and move every widget into the right section, in
# this order: tray, system-update, indicators, weather, agents, bluetooth,
# network, microphone, audio, monitor, power, clock, orivo-plugin, keyboard-layout.
omarchy plugin enable omarchy.system-update --section right --after omarchy.tray
omarchy plugin enable omarchy.indicators --section right --after omarchy.system-update
omarchy plugin enable omarchy.weather --section right --after omarchy.indicators
omarchy plugin enable omarchy.agents --section right --after omarchy.weather
omarchy plugin enable omarchy.bluetooth --section right --after omarchy.agents
omarchy plugin enable omarchy.network --section right --after omarchy.bluetooth
omarchy plugin enable omarchy.microphone --section right --after omarchy.network
omarchy plugin enable omarchy.audio --section right --after omarchy.microphone
omarchy plugin enable omarchy.monitor --section right --after omarchy.audio
omarchy plugin enable omarchy.power --section right --after omarchy.monitor
omarchy plugin enable omarchy.clock --section right --after omarchy.power
omarchy plugin enable omarchy-orivo-plugin --section right --after omarchy.clock
omarchy plugin enable omarchy.keyboard-layout --section right --after omarchy-orivo-plugin
