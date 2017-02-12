#!/bin/bash
echo "=== Attempting to create user to match owner of volume mounted at /tmp"
userid=`stat -c %u /tmp`

echo "=== Executing as root because /tmp is owned by root."
[[ $userid = 0 ]] && exec "$@"

echo "=== Executing command as root because uid for mounted volume already exists."
getent passwd ${userid} &&  exec "$@"

echo "=== Adding user 'someuser' with uid ${userid} to match owner of /tmp"
adduser --shell /bin/bash --uid ${userid} --disabled-password --gecos '' someuser
export HOME=/home/someuser
export SHELL=/bin/bash
chown -R someuser:someuser /opt/conda
echo "=== Passing control to 'someuser' with uid ${userid} to run: $@"
exec gosu someuser "$@"
