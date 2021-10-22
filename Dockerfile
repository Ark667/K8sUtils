FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Install default modules
RUN apt-get update && apt-get upgrade
RUN apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        wget \
        unzip \
        nano \
        git \
        awscli \
        jq \
        curl

WORKDIR /home

# Download and install Yaml editor tool
COPY ./src/update-yamlcli.sh /home/update-yamlcli.sh
RUN chmod +x /home/update-yamlcli.sh
RUN ./update-yamlcli.sh

# Download last stable version of Kubectl
COPY ./src/update-kubectl.sh /home/update-kubectl.sh
RUN chmod +x /home/update-kubectl.sh
RUN ./update-kubectl.sh

# Download last stable version of Kops
COPY ./src/update-kops.sh /home/update-kops.sh
RUN chmod +x /home/update-kops.sh
RUN ./update-kops.sh

# Download last stable version of Linkerd
COPY ./src/update-linkerd.sh /home/update-linkerd.sh
RUN chmod +x /home/update-linkerd.sh
RUN ./update-linkerd.sh

# Copy create_cluster script
COPY ./src/create-cluster.sh /home/create-cluster.sh
RUN chmod +x /home/create-cluster.sh

