FROM node:18.12.1-bullseye

RUN npm install -g npm@9.8.0
RUN npm install -g ironfish@v1.5.0

CMD ["ironfish","start", "--rpc.ipc", "--rpc.tcp"]
