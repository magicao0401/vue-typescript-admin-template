FROM nginx:latest

CMD [ "/usr/sbin/nginx", "-g", "daemon off;" ] 

COPY ./nginx.conf /etc/nginx/
COPY dist /opt/web/
EXPOSE 80
