FROM             node:16.18.1-alpine3.17 as build-stage
WORKDIR          /app
COPY             . .
RUN              npm install
RUN              npm run build

FROM             nginx:1.23.2-alpine as production-stage
COPY             --from=build-stage /app/dist /usr/share/nginx/html
COPY             nginx_default.conf /etc/nginx/conf.d/default.conf
EXPOSE           80
CMD              ["nginx", "-g", "daemon off;"]
