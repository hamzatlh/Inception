FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install nginx -y

RUN apt install -y openssl

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/htalhaou.42.fr.key \
    -out /etc/nginx/ssl/htalhaou.42.fr.crt  \
    -subj "/C=MA/L=Tetouan/O=42/OU=1337 MED/CN=htalhaou.42.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]