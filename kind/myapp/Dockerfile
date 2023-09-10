FROM golang:1.21.1

WORKDIR /app

COPY go.mod .
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /myapp

CMD ["/myapp"]
