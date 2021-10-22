#!/bin/bash

apt-get update && apt-get upgrade

# Download and install Yaml editor tool (https://github.com/Gallore/yaml_cli)
apt-get install \
        python \
        python-pip
git clone https://github.com/Gallore/yaml_cli
pip install setuptools
pip install ./yaml_cli