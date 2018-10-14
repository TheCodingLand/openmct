FROM node:latest as builder
RUN mkdir -p /usr/src/app/openmct
WORKDIR /usr/src/app/openmct/

RUN npm i

COPY . /usr/src/app/openmct
COPY custom/html/index.html .
COPY custom/root/ .
CMD node app.js -p 80 --host "0.0.0.0"



