FROM node:latest as builder
RUN mkdir -p /usr/src/app/openmct
WORKDIR /usr/src/app/openmct/

COPY bower.json .
COPY package.json .
COPY gulpfile.js .

RUN npm i
RUN node ./node_modules/bower/bin/bower install --allow-root
COPY . /usr/src/app/openmct
#replace files with custom data
COPY custom/ .
RUN node ./node_modules/gulp/bin/gulp.js install

FROM nginx:alpine
ADD ./custom/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/openmct/index.html /usr/share/nginx/openmct/index.html
COPY --from=builder /usr/src/app/openmct/dist /usr/share/nginx/openmct/dist
CMD ["nginx", "-g", "daemon off;"]

