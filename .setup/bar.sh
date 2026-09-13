#!/bin/bash

set -e

omarchy bar position bottom

# Move every center-section bar widget to the right section, in this order:
# tray, system-update, indicators, weather, agents, bluetooth, network,
# microphone, audio, monitor, power, clock, orivo-plugin, keyboard-layout.
omarchy bar move omarchy.system-update --section right --after omarchy.tray
omarchy bar move omarchy.indicators --section right --after omarchy.system-update
omarchy bar move omarchy.weather --section right --after omarchy.indicators
omarchy bar move omarchy.agents --section right --after omarchy.weather
omarchy bar move omarchy.bluetooth --section right --after omarchy.agents
omarchy bar move omarchy.network --section right --after omarchy.bluetooth
omarchy bar move omarchy.microphone --section right --after omarchy.network
omarchy bar move omarchy.audio --section right --after omarchy.microphone
omarchy bar move omarchy.monitor --section right --after omarchy.audio
omarchy bar move omarchy.power --section right --after omarchy.monitor
omarchy bar move omarchy.clock --section right --after omarchy.power
omarchy bar move omarchy-orivo-plugin --section right --after omarchy.clock
omarchy bar move omarchy.keyboard-layout --section right --after omarchy-orivo-plugin
