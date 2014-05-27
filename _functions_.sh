#!/bin/bash

## <FUNCTIONS

script_begin() {
    TMPDIR="$(mktemp -d)"
    OLD_PWD=$PWD
}

script_end() {
    cd $OLD_PWD
    rm -rf $TMPDIR
}

####################

script_get_lockname() {
    SCRIPTNAME="$(basename $0)"
    LOCKNAME="/var/tmp/$SCRIPTNAME.lock"
}

script_begin_single() {
    script_get_lockname
    if [ -f $LOCKNAME ]; then
	echo "$SCRIPTNAME is already running! Exiting..."
	exit 1
    else
	touch $LOCKNAME
    fi
    #
    script_begin
}

script_end_single() {
    script_end
    #
    script_get_lockname
    if [ -f $LOCKNAME ]; then
	rm -f $LOCKNAME
    else
	echo "$SCRIPTNAME is dead! May be errors?!..."
    fi
}

## FUNCTIONS>
