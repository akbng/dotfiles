#!/bin/bash

SUDO=''
if [ "$EUID" -ne 0 ]; then
  SUDO='sudo'
fi

# TODO: use sed to get the value of disk space freed from the outputs
# TODO: compute the total disk space freed up
# example of sed in action: script_shell="$(readlink /proc/$$/exe | sed "s/.*\///")"
# initialize the variable script_shell to the name of the shell instead of /bin/bash or /usr/bin/zsh

$SUDO apt auto-remove

if [ $@ ]
then
    echo "List of packages to remove: $@"
    echo -n | $SUDO apt-get purge $@ | grep "disk space will be freed"
    -$SUDO apt purge $@ -y
else
    echo "No packages to remove"
fi

$SUDO apt-get autoclean

$SUDO journalctl --vacuum-time=1d

set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        $SUDO snap remove "$snapname" --revision="$revision"
    done

rm -rf ~/.cache/thumbnails/*

if ! [ -x "$(command -v fdupes)" ]; then
    $SUDO apt install fdupes
fi

fdupes -r -d -N -s $HOME/Downloads