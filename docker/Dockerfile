FROM node:18.17.1-bullseye

RUN npm install -g npm@10.1.0
RUN npm install -g ironfish@v1.9.0

CMD ["ironfish","start", "--rpc.ipc", "--rpc.tcp"]
