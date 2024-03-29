FROM golang:1.16.5-alpine

WORKDIR /code/
ADD ./ /code/

RUN apk update && apk upgrade && \
    apk add --no-cache git

RUN go mod download

ARG ENV_VAR_EXISTS
ARG DATABASE_HOST
ARG DATABASE_USER
ARG DATABASE_PASSWORD
ARG DATABASE_URI

ENV ENV_VAR_EXISTS=$ENV_VAR_EXISTS
ENV DATABASE_HOST=$DATABASE_HOST
ENV DATABASE_USER=$DATABASE_USER
ENV DATABASE_PASSWORD=$DATABASE_PASSWORD
ENV DATABASE_URI=$DATABASE_URI

RUN go build -o .bin/news-portal cmd/news-portal/main.go
CMD [".bin/news-portal"]