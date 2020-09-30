FROM ubuntu:latest

LABEL maintainer="Neer Patel <neerpatel@gmail.com>"

ENV NGINX_VERSION   1.18.0

RUN set -x && \
# create nginx user/group first, to be consistent throughout docker variants
    addgroup --system --gid 101 nginx && \
    adduser --system --disabled-login --ingroup nginx --no-create-home --home /nonexistent --gecos "nginx user" --shell /bin/false --uid 101 nginx && \
    apt-get update && apt-get upgrade -y && \
    apt-get install -y wget libpcre3-dev build-essential libssl-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /tmp/build/nginx && \
    cd /tmp/build/nginx && \
    wget -O nginx-${NGINX_VERSION}.tar.gz  https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz  && \
    tar -zxf nginx-${NGINX_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    ./configure \
        --sbin-path=/usr/local/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --with-stream && \
    make -j $(getconf _NPROCESSORS_ONLN) && \
    make install && \
    mkdir /var/lock/nginx && \
    rm -rf /tmp/build && \
    apt-get purge -y --auto-remove wget libpcre3-dev build-essential libssl-dev zlib1g-dev make && \
    ln -sf /dev/stdout /var/log/nginx/dns.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf

RUN chown -R nginx:nginx /usr/local/sbin/nginx && chmod -R 755 /usr/local/sbin/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/nginx.conf && chmod -R 755 /etc/nginx/nginx.conf
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid && \
    touch /usr/local/nginx/logs/nginx.pid && \
        chown -R nginx:nginx /usr/local/nginx/logs/nginx.pid

USER nginx

EXPOSE 5353

RUN cat /etc/nginx/nginx.conf
RUN nginx -v
RUN nginx -t
ENTRYPOINT ["nginx", "-g", "daemon off;"]
