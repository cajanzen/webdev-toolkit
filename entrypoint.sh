#!/bin/bash
userid=`stat -c %u /tmp`

[[ $userid = 0 ]] && {
exec "$@"
echo "=== Executing as root because /tmp is owned by root."
}

getent passwd ${userid} && {
echo "=== Executing command as root because uid for mounted volume already exists."
exec "$@"
}

echo "=== Adding user 'someuser' with uid ${userid} to match owner of /tmp"
adduser --home /home/otheruser --shell /bin/bash --uid ${userid} --disabled-password --gecos '' someuser
export HOME=/home/someuser
export SHELL=/bin/bash
#chown -R someuser:someuser /opt/conda
#chown -R someuser:someuser /home/someuser
echo "=== Passing control to 'someuser' with uid ${userid} to run: $@"
exec gosu someuser "$@"
