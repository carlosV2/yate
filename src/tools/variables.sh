#!/usr/bin/env bash

#
# This file prepares any `((VAR))` to be replaced by the output of `echo $VAR`.
#
# Parameters:
# $1: Text to parse
#
# Output:
# List of regexes to apply in order to get the variables values replaced.
#

pattern=""

while read -r match; do
    value="$(eval "echo \"\$${match:2:${#match}-4}\"")"

    pattern="${pattern} s/$(nsrc "protect.sh" "${match}")/$(nsrc "protect.sh" "${value}")/g;"
done < <(echo "${1}" | grep -oE "\(\(.+?\)\)" | uniq)

echo "${pattern}"
