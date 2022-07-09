FROM node:14-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
FROM nginx:1.17.1-alpine
RUN rm -rf /usr/share/nginx/html/*
RUN rm -rf /etc/nginx/nginx.conf
COPY --from=build /app/dist/ca-frontend /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf