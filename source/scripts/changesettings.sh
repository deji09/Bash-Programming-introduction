#!/bin/bash
# Changes settings in configuaration files that can be set by the user

$configPath = $2
source $configPath

echo "Current global settings:"
echo "Configuration file: $configPath"
echo "Default editor: $editor"
echo "Auto Update: $autoUpdate"