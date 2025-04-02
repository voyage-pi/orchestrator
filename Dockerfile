FROM node:22-alpine as build
WORKDIR /app
COPY ./frontend/ui/package*.json ./
RUN npm install
COPY ./frontend/ui .
RUN npm run build

FROM nginx:alpine
COPY ./nginx.prod.conf /etc/nginx/nginx.conf
COPY ./certs/certificate.crt /etc/ssl/certificate.crt
COPY ./certs/private.key /etc/ssl/private.key
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
