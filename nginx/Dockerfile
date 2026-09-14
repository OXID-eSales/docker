FROM debian:trixie-slim

# nginx-extras brings Debian's nginx with the lua and headers-more modules the NGINX module config needs
RUN apt-get update && \
    apt-get install nginx-extras -y && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/cache/oxid-main
RUN mkdir -p /var/www/cache/oxid-media

# forward the default logs to docker, as the official nginx image does
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]
