FROM node:18.12.1-bullseye

RUN npm install -g ironfish@{{IRONFISH_VERSION}}

CMD ["ironfish","start", "--rpc.ipc", "--rpc.tcp"]