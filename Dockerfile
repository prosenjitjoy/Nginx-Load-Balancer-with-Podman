FROM golang:1.20

WORKDIR /usr/src/app

COPY go.mod main.go ./

RUN go build -v -o /usr/local/bin/app ./...

EXPOSE 8080

CMD ["app"]