FROM golang:1.21.1 AS build

WORKDIR /app

COPY go.mod .
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /myapp

FROM alpine:latest

WORKDIR /

COPY --from=build /myapp /myapp

EXPOSE 8000

CMD ["/myapp"]
