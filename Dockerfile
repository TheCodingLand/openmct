FROM node:latest as builder
RUN mkdir -p /usr/src/app/openmct
WORKDIR /usr/src/app/openmct/

COPY . /usr/src/app/openmct

COPY custom/html/index.html .
COPY custom/root/ .

RUN npm install
RUN node ./node_modules/bower/bin/bower install --allow-root
RUN node ./node_modules/gulp/bin/gulp.js install

CMD node app.js -p 80 --host "0.0.0.0"



