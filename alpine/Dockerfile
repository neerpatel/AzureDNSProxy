FROM alpine:3.11

LABEL maintainer="Neer Patel <neerpatel@gmail.com>"

ENV NGINX_VERSION   1.18.0

RUN set -x && \
# create nginx user/group first, to be consistent throughout docker variants
    addgroup -g 101 -S nginx && \
    adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx && \
    tempDir="$(mktemp -d)" && \
    chown nobody:nobody $tempDir && \
    build_pkgs="build-base linux-headers openssl-dev pcre-dev wget zlib-dev" && \
    runtime_pkgs="ca-certificates openssl pcre zlib tzdata git" && \
    apk --no-cache add ${build_pkgs} ${runtime_pkgs} && \
    cd $tempDir && \
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
    ln -sf /dev/stdout /var/log/nginx/dns.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    rm -rf $tempDir && \
    apk del ${build_pkgs} && \
    rm -rf /var/cache/apk/*


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
