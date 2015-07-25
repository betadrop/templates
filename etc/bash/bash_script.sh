#!/bin/bash

set -o errexit

example_func() {
    local l="local read write"

    if [[ "$l" == *read* ]]; then
	echo "This should print"
    fi
    if [[ "$l" == "*read*" ]]; then
	echo "This should not print"
    fi

    readonly ro="read only"
    case $ro in
	*read* ) echo "This should print" ;;
	* ) echo "default" ;;
    esac
}

string_manip() {
    readonly f="usr/local/one_usr.xx"
    echo "[$f]"
    echo
    echo "substitute:         [${f/usr/sub}]"  # [sub/local/one_usr.xx]
    echo "global subst:       [${f//usr/sub}]" # [sub/local/one_sub.xx]
    echo "regex subst:        [${f/u?r/sub}]"  # [sub/local/one_usr.xx]
    echo "global regex subst: [${f//u?r/sub}]" # [sub/local/one_sub.xx]
    echo
    echo "del begin:         [${f#*/}]"  # [local/one_usr.xx]
    echo "greedy:            [${f##*/}]" # [one_sub.xx]
    echo "del end:           [${f%/*}]"  # [usr/local]
    echo "greedy:            [${f%%/*}]" # [usr]
}

forward_params() {
    while [[ -n "$1" ]]; do
	printf "param %s\n" $1
	shift
    done
}

# forward_params "$@"
# string_manip

