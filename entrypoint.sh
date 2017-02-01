#!/bin/bash
# change current user id to match the /code directory
userid=`stat -c %u /code`

# exit if user is root
[[ $userid = 0 ]] && exec "$@"

# exit if user already exists
getent passwd ${userid} &&  exec "$@"

adduser --shell /bin/bash --uid ${userid} --disabled-password --gecos '' someuser
export HOME=/home/someuser
export SHELL=/bin/bash
chown -R someuser:someuser /opt/conda
exec gosu someuser "$@"
