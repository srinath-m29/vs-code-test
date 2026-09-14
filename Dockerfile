FROM gitpod/openvscode-server:latest

EXPOSE 10000

CMD ["--host", "0.0.0.0", "--port", "10000", "--without-connection-token"]
