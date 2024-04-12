FROM node:lts-alpine AS builder
WORKDIR /app

COPY package*.json .
COPY index.html .
COPY vite.config.js .
COPY src /app/src
COPY public /app/public

RUN npm install
RUN npx vite build

FROM nginx:1.16 as nginx

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]