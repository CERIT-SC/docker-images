# Docker Images

Various docker image sources used in CERIT-SC Kubernetes infrastructure. Can be used as base or inspiration for other images.

## base-os

This folder contains base Ubuntu images created with working `sudo` and are able to add new packages in runtime. They must run as user with id `1000` to be usable.

## desktop

This folder contains base (XFCE) desktop images, they source base-os images and must run as id `1000`.

## jupyternotebooks

This folder contains base Minimal Notebook for Jupyterhub with working sudo and optionally with ssh.
