FROM node:latest as builder
RUN mkdir -p /usr/src/app/openmct
WORKDIR /usr/src/app/openmct/

COPY bower.json .
COPY package.json .
COPY gulpfile.js .

RUN npm i
COPY custom/html/index.html .
RUN node ./node_modules/bower/bin/bower install --allow-root
COPY . /usr/src/app/openmct
#replace files with custom data
COPY custom/root/ .
RUN npm start -p 80 -h '0.0.0.0'


