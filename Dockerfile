FROM gitlabregistry.elyas.ir/elyas/nginx_alpine:latest
RUN rm -rf /etc/nginx/*
COPY . /etc/nginx/
RUN rm -rf /etc/nginx/conf.d && \
    mv /etc/nginx/conf.d.docker /etc/nginx/conf.d
EXPOSE 80 443
