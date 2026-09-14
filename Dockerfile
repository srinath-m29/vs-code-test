FROM gitpod/openvscode-server:latest

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        gcc \
        g++ \
        make \
        git \
    && rm -rf /var/lib/apt/lists/*

RUN chown -R openvscode-server:openvscode-server \
    /home/workspace \
    /home/.openvscode-server

USER openvscode-server
