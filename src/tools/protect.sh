#!/usr/bin/env bash

#
# This script escapes any regex character susceptible to be interpreted as part of the pattern;
#
# Parameters:
# $1: Text to escape
#
# Output:
# The escaped string
#

echo "${1}" | sed -e 's/[]\/$*.^|[]/\\&/g'
