FROM node:13.13.0-alpine

WORKDIR /usr/src/app

CMD ["yarn", "serve"]