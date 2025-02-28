#!/bin/bash
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

(export LD_LIBRARY_PATH=''; rm -f /etc/ssh/ssh_host_*; for i in rsa dsa ecdsa ed25519; do ssh-keygen -q -f /etc/ssh/ssh_host_${i}_key -N '' -t $i; ssh-keygen -f /etc/ssh/ssh_host_${i}_key.pub; done)

set -e

# The Jupyter command to launch
# JupyterLab by default
DOCKER_STACKS_JUPYTER_CMD="${DOCKER_STACKS_JUPYTER_CMD:=lab}"

if [[ -n "${JUPYTERHUB_API_TOKEN}" ]]; then
    echo "WARNING: using start-singleuser.sh instead of start-notebook.sh to start a server associated with JupyterHub."
    exec /usr/local/bin/start-singleuser.sh "$@"
fi

wrapper=""
if [[ "${RESTARTABLE}" == "yes" ]]; then
    wrapper="run-one-constantly"
fi

export NVM_DIR="/usr/local/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# shellcheck disable=SC1091,SC2086
exec /usr/local/bin/start.sh ${wrapper} jupyter ${DOCKER_STACKS_JUPYTER_CMD} ${NOTEBOOK_ARGS} "$@"
