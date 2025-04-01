from nginx:latest

COPY ./nginx.prod.conf /etc/nginx/nginx.conf

EXPOSE 443
