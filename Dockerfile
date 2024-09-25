FROM node:20.17.0-alpine AS base

WORKDIR /var/www/
ENV APP_VERSION=3.13.7
ENV APP_PORT=3000

#----------------
# DEV
#----------------
FROM base AS dev

RUN npm install -g nodemon

COPY ./docker/start-dev.sh /scripts/start-dev.sh 
RUN chmod +x /scripts/start-dev.sh 
ENTRYPOINT ["sh", "-c", "/scripts/start-dev.sh"]

#----------------
# PROD
#----------------
FROM base AS prod

COPY ./ ./
RUN npm config set fetch-retry-mintimeout 100000 && \
npm ci

COPY ./docker/start-prod.sh /scripts/start-prod.sh 
RUN chmod +x /scripts/start-prod.sh 
ENTRYPOINT ["/scripts/start-prod.sh"]