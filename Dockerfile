FROM nginx:1.27-alpine
ENV PORT=10000
COPY survey-says.html game.json* /usr/share/nginx/html/
RUN mkdir -p /etc/nginx/templates \
 && mv /usr/share/nginx/html/survey-says.html /usr/share/nginx/html/index.html \
 && printf 'server {\n  listen ${PORT};\n  root /usr/share/nginx/html;\n  location / {\n    try_files $uri $uri/ =404;\n    add_header Cache-Control "no-store";\n  }\n  location = /health { return 200 "ok"; }\n}\n' > /etc/nginx/templates/default.conf.template
EXPOSE 10000
