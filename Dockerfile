FROM golang:1.11 as builder

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo -ldflags '-w' -o hello-osiris *.go

FROM alpine:3.8
COPY --from=builder /app/hello-osiris /bin/hello-osiris
ENTRYPOINT ["/bin/hello-osiris"]