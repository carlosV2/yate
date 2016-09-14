#!/usr/bin/env bash

#
# This file prepares any `{{COMMAND}}` to be replaced by the output of the command `COMMAND`.
#
# Parameters:
# $1: Text to parse
#
# Output:
# List of regexes to apply in order to get the expressions evaluated.
#

pattern=""

while read -r match; do
    code="$(echo "${match:2:${#match}-4}" | sed "s/\\$/\\\\$/g")"
    value="$(eval "${code}")"

    pattern="${pattern} s/$(nsrc "protect.sh" "${match}")/$(nsrc "protect.sh" "${value}")/g;"
done < <(echo "${1}" | grep -oE "\{\{.+?\}\}" | uniq)

echo "${pattern}"
