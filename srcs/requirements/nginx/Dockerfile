FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y nginx

RUN mkdir -p /etc/nginx/ssl

RUN apt install -y openssl && openssl req -x509 -nodes -out /etc/nginx/ssl/htalhaou.42.fr.crt -keyout /etc/nginx/ssl/htalhaou.42.fr.key -subj "/C=MA/ST=IDF/L=Tetouan/O=1337/OU=1337/CN=htalhaou.42.fr/UID=htalhaou" 

COPY ./conf/nginx.conf /etc/nginx/conf.d/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
