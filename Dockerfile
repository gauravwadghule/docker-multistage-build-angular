FROM alpine AS stage1
WORKDIR app
RUN apk add --update nodejs npm
RUN node -v && npm -v
RUN npm install -g @angular/cli
RUN ng config -g cli.warnings.versionMismatch false
RUN ng version
COPY ./ /app
RUN npm i && ng build

FROM nginx
WORKDIR /usr/share/nginx/html
COPY --from=stage1 /app/dist/*/ ./
CMD nginx -s reload

