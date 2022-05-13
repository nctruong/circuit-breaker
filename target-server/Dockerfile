FROM node:12.18.1
ENV NODE_ENV=production

WORKDIR /server

COPY package.json /server/package.json

RUN yarn install --production

COPY . .
EXPOSE 4000
CMD [ "yarn", "start" ]