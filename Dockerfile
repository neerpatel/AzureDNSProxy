FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --force-yes nginx

EXPOSE 53
VOLUME [ "/var/logs/nginx" ]
COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-t"]