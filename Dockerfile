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

USER openvscode-server

EXPOSE 10000

ENTRYPOINT ["/bin/sh", "-c", \
    "exec /home/.openvscode-server/bin/openvscode-server \
    --host 0.0.0.0 \
    --port ${PORT:-10000} \
    --connection-token ${OPENVSCODE_TOKEN}"]
