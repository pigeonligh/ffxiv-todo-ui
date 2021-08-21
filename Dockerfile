FROM registry.cn-shanghai.aliyuncs.com/pigeonligh/build:node-14.17.5-alpine AS build

WORKDIR /build

ADD package.json ./
ADD package-lock.json ./

RUN npm install

ADD . ./

RUN npm run build

FROM registry.cn-shanghai.aliyuncs.com/pigeonligh/runtime:nginx-alpine

WORKDIR /app

COPY --from=build /build/dist ./

EXPOSE 80
