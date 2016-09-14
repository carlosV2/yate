#!/usr/bin/env bash

#
# This file returns any given text with the `((VAR))`, `{{COMMAND}}` and `[[FORMAT]]` patterns replaced
#
# Parameters:
# $1: Text to process
#
# Output:
# Patterns-replaced text
#

source "$(dirname "${BASH_SOURCE[0]}")/vendor/autoload.sh"

patterns="$(nsrc "tools/variables.sh" "${1}") $(nsrc "tools/expressions.sh" "${1}") $(nsrc "tools/format.sh" "${1}")"

echo -e "$(echo "${1}" | sed "${patterns}")\033[0m"
