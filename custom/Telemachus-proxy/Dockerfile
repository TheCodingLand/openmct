FROM nginx:alpine
ENV IP = "192.168.1.42"


ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf
RUN sed -i -e 's/IP_ADDRESS/${IP}/g' /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
