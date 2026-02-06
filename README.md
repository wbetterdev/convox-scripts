# Convox Scripts

This repository initially started as a tool for linking NP microservices between them but then ended up containing everthing we use for local development and deployment.

## Contents
1. Scripts for installing all the necesarry programs and utilities (based on Ubuntu LTS 20.04 packages). You can find them in `/scripts/installs`.
2. Scripts for deploying to OP services [Docs](/doc/op-scripts.md)
3. Scripts for setting up your linux user bash aliases and profiles. You can find them in  `/configs/linux-user/bash/` [TODO Add Docs](/)
4. Scripts for starting and configuring NP service. [TODO Add Docs](/)
5. Scripts for running an apache server as a proxy for linking NP and OP services in between then and having HTTPS work via self signed certificates that you can find in `/certs/apache`.
6. Configuration templates needed when creating a new development environment. You can find these in `/configs/templates/` 


## NP scripts and their usage
TODO: add docs here
1. [npsconfig](/doc/np-scripts.md#nps-config) - script that links services in between them. Run this when you switch location for services. e.g. switch from using an external user service to running a local user service.
2. [npsenv](/doc/np-scripts.md#nps-env) - script builds environment variables needed for a service to run
3. [npsinstall](/doc/np-scripts.md#nps-install)
4. [npsrun](/doc/np-scripts.md#nps-run)


## Documentation
1. [Installation](/doc/installation.md)
2. [Creating and deploying releases](/doc/releasing-on-op.md)
