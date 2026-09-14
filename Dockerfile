FROM debian:11-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        git \
        python3 \
        python3-pip \
        python3-venv \
        gcc \
        g++ \
        make \
        libatomic1 \
        libstdc++6 \
        libgcc-s1 \
        bash \
    && rm -rf /var/lib/apt/lists/*

ARG RELEASE_TAG

RUN test -n "$RELEASE_TAG" && \
    wget -q \
    "https://github.com/gitpod-io/openvscode-releases/releases/download/${RELEASE_TAG}/${RELEASE_TAG}-linux-x64.tar.gz" \
    -O /tmp/openvscode.tar.gz && \
    tar -xzf /tmp/openvscode.tar.gz -C /opt && \
    mv "/opt/${RELEASE_TAG}-linux-x64" /opt/openvscode && \
    rm /tmp/openvscode.tar.gz

RUN useradd -m -s /bin/bash vscode && \
    mkdir -p /workspace && \
    chown -R vscode:vscode /workspace /opt/openvscode

USER vscode

WORKDIR /workspace

EXPOSE 10000

ENTRYPOINT ["/bin/bash", "-c", \
    "exec /opt/openvscode/bin/openvscode-server \
    --host 0.0.0.0 \
    --port ${PORT:-10000} \
    --connection-token ${OPENVSCODE_TOKEN}"]
