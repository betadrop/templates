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

for_loops() {
    # 1 3 5 7 9
    local first=1
    local incr=2
    local last=9
    for i in $(seq $first $incr $last); do
	printf "%d " $i
    done
    printf "\n"
    for (( i = $first; i <= $last; i = i+2 )); do
	printf "%d " $i 
    done
    printf "\n"
}

forward_params() {
    while [[ -n "$1" ]]; do
	printf "param %s\n" $1
	shift
    done
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

wait_pid() {
    /usr/bin/sleep 10 &
    pid=$!
    echo "sleep has pid $pid" 
    wait $pid
}

# forward_params "$@"
# string_manip
# wait_pid
for_loops

