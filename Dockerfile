FROM node:alpine AS builder

RUN mkdir -p /usr/app
WORKDIR /usr/app

## Install dependencies
COPY ["./package.json", "./package-lock.json", "/usr/app/"]

RUN npm install

## Add source code
COPY ["./tsconfig.json", "/usr/app/"]
COPY "./src" "/usr/app/src/"

## Build
RUN npm run build

# PRODUCTION IMAGE
FROM node:alpine

RUN mkdir -p /usr/app
WORKDIR /usr/app

COPY --from=builder [\
  "/usr/app/package.json", \
  "/usr/app/package-lock.json", \
  "/usr/app/" \
  ]

COPY --from=builder "/usr/app/dist/src" "/usr/app/dist/src"

RUN npm ci --only=production --ignore-script

EXPOSE 3000

ENTRYPOINT [ "npm", "start" ]
