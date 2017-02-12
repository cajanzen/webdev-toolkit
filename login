#!/usr/bin/env bash
export HOME=/home/someuser
export SHELL=/bin/bash
[ -z "$@" ] && gosu someuser bash ; exit 0
gosu someuser "$@" ; exit 0
