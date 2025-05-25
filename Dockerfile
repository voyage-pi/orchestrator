FROM node:22-alpine as build-frontend
WORKDIR /app
COPY ./frontend/ui/package*.json ./
RUN npm install
COPY ./frontend/ui .
RUN npm run build

FROM node:22-alpine as build-landing
WORKDIR /app
COPY ./landing-page/package*.json ./
RUN npm install
COPY ./landing-page .
RUN npm run build

FROM nginx:alpine
COPY ./nginx.prod.conf /etc/nginx/nginx.conf
COPY ./certs/voyage_certificate.crt /etc/ssl/voyage_certificate.crt
COPY ./certs/voyage_private.key /etc/ssl/voyage_private.key
COPY ./certs/landing_certificate.crt /etc/ssl/landing_certificate.crt
COPY ./certs/landing_private.key /etc/ssl/landing_private.key
COPY --from=build-frontend /app/dist /usr/share/nginx/html
COPY --from=build-landing /app/dist /usr/share/nginx/html/landing
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
