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
RUN node ./node_modules/gulp/bin/gulp.js install

FROM nginx:alpine
ADD ./custom/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/openmct/index.html /usr/share/nginx/openmct/index.html
COPY --from=builder /usr/src/app/openmct/dist /usr/share/nginx/openmct/dist
COPY --from=builder /usr/src/app/openmct/example /usr/share/nginx/openmct/example
COPY --from=builder /usr/src/app/openmct/platform /usr/share/nginx/openmct/platform
CMD ["nginx", "-g", "daemon off;"]

