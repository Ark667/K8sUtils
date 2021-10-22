#!/bin/bash

# Download and install Linkerd (https://github.com/linkerd/linkerd2/releases)
version=$(curl -Ls https://api.github.com/repos/linkerd/linkerd2/releases | jq -r '.[0].tag_name')
curl -Lo linkerd https://github.com/linkerd/linkerd2/releases/download/$version/linkerd2-cli-$version-linux-amd64
chmod +x linkerd
mv linkerd /usr/local/bin/linkerd