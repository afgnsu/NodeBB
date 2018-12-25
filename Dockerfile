# The base image is the latest 8.x node (LTS)
FROM node:8.14.1@sha256:c2bf519e9ccf3b24dbd2465cb5e2022f02e2d59c773df7cb1819fb9e665d6e85

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
COPY install/package.json /usr/src/app/package.json
RUN npm install && npm cache clean --force
COPY . /usr/src/app

ENV NODE_ENV=production \
    daemon=false \
    silent=false

CMD ./nodebb start

# the default port for NodeBB is exposed outside the container
EXPOSE 4567