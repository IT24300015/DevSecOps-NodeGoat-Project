FROM node:12-alpine

ENV WORKDIR /usr/src/app/

WORKDIR $WORKDIR

COPY package*.json $WORKDIR

RUN npm config set strict-ssl false && npm config set registry https://registry.npmmirror.com && npm install --production --no-cache

FROM node:12-alpine

ENV USER node

ENV WORKDIR /home/$USER/app

WORKDIR $WORKDIR

COPY --from=0 /usr/src/app/node_modules node_modules

RUN chown $USER:$USER $WORKDIR

COPY --chown=node . $WORKDIR

USER $USER

EXPOSE 4000