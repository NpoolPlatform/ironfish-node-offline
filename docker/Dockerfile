FROM node:18.12.1-bullseye

ARG IRONFISH_VERSION
RUN npm install -g ironfish@$IRONFISH_VERSION

CMD ["ironfish","start", "--rpc.ipc", "--rpc.tcp"]