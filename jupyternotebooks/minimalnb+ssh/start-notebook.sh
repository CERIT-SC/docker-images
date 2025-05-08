#!/bin/bash
# Shim to emit warning and call start-notebook.py
echo "WARNING: Use start-notebook.py instead"

# generate new ssh keys
(export LD_LIBRARY_PATH=''; rm -f /etc/ssh/ssh_host_*; for i in rsa dsa ecdsa ed25519; do ssh-keygen -q -f /etc/ssh/ssh_host_${i}_key -N '' -t $i; done)

# avoid possible conda conficts
LD_LIBRARY_PATH='' /usr/sbin/sshd

exec /usr/local/bin/start-notebook.py "$@"
