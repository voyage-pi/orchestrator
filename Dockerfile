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
COPY ./certs/certificate.crt /etc/ssl/certificate.crt
COPY ./certs/private.key /etc/ssl/private.key
COPY --from=build-frontend /app/dist /usr/share/nginx/html
COPY --from=build-landing /app/dist /usr/share/nginx/html/landing
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
