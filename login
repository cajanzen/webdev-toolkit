#!/usr/bin/env bash
export HOME=/home/someuser
export SHELL=/bin/bash
[ -z "$@" ] && gosu someuser bash
gosu someuser "$@"
