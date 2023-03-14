FROM ghcr.io/iron-fish/ironfish:latest

RUN mkdir -p /root/.ironfish
COPY ./config.json /root/.ironfish
COPY ./internal.json /root/.ironfish

WORKDIR /usr/src/app
ENTRYPOINT ["./entrypoint.sh"]
CMD ["start", "--rpc.ipc", "--rpc.tcp"]