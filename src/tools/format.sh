#!/usr/bin/env bash

#
# This file prepares any `[[FORMAT]]` to be replaced by the corresponing format tag.
# The available formats are:
# F.COLOR: Sets the foreground color to COLOR
# B.COLOR: Sets the background color to COLOR
# S.STYLE: Sets the style to STYLE
#
# Parameters:
# $1: Text to parse
#
# Output:
# List of regexes to apply in order to get the format tags replaced.
#

pattern=""

while read -r match; do
    property="$(echo "${match:2:${#match}-4}" | cut -d"." -f1 | tr "[:lower:]" "[:upper:]")"
    value="$(echo "${match:2:${#match}-4}" | cut -d"." -f2- | tr "[:lower:]" "[:upper:]")"

    if [[ "${property}" == "S" ]]; then
        case "${value}" in
            "BOLD")      value="\033[1m";;
            "DIM")       value="\033[2m";;
            "UNDERLINE") value="\033[4m";;
            "BLINK")     value="\033[5m";;
            "REVERSE")   value="\033[7m";;
            "HIDDEN")    value="\033[8m";;
            "NONE")      value="\033[21;22;24;25;27;28m";;
            *)           value="";;
        esac
    elif [[ "${property}" == "F" ]] || [[ "${property}" == "B" ]]; then
        base=30
        if [[ "${property}" == "B" ]]; then
            base=40
        fi

        case "${value}" in
            "BLACK")         value="\033[$((base + 0))m";;
            "RED")           value="\033[$((base + 1))m";;
            "GREEN")         value="\033[$((base + 2))m";;
            "YELLOW")        value="\033[$((base + 3))m";;
            "BLUE")          value="\033[$((base + 4))m";;
            "MAGENTA")       value="\033[$((base + 5))m";;
            "CYAN")          value="\033[$((base + 6))m";;
            "LIGHT GRAY")    value="\033[$((base + 7))m";;
            \#*)             value="\033[$((base + 8));5;${value:1}m";;
            "NONE")          value="\033[$((base + 9))m";;
            "GRAY")          value="\033[$((base + 60))m";;
            "LIGHT RED")     value="\033[$((base + 61))m";;
            "LIGHT GREEN")   value="\033[$((base + 62))m";;
            "LIGHT YELLOW")  value="\033[$((base + 63))m";;
            "LIGHT BLUE")    value="\033[$((base + 64))m";;
            "LIGHT MAGENTA") value="\033[$((base + 65))m";;
            "LIGHT CYAN")    value="\033[$((base + 66))m";;
            "WHITE")         value="\033[$((base + 67))m";;
        esac
    else
        value=""
    fi

    pattern="${pattern} s/$(nsrc "protect.sh" "${match}")/$(nsrc "protect.sh" "${value}")/g;"
done < <(echo "${1}" | grep -oE "\[\[.+?\]\]" | uniq)

echo "${pattern}"
