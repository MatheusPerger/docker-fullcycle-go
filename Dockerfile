FROM golang:1.24.2 AS builder

WORKDIR /app
COPY app/ .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -ldflags="-s -w" -o app

FROM scratch

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]