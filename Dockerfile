FROM nginx:latest

CMD [ "/usr/sbin/nginx", "-g", "daemon off;" ] 

COPY docker/nginx.conf /etc/nginx/
COPY dist /opt/web/
EXPOSE 80