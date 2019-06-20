# Stage 1. Build the binary
FROM golang:1.12-alpine3.9 as builder

# install git
RUN apk add --no-cache --update \
	git openssl

WORKDIR /app

ADD . /app
RUN go get

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /ingress-jwt-auth .

# Stage 2. Run the binary
FROM alpine:3.9
# ca-certificates are required for Google Storage SDK to access https://storage.googleapis.com
RUN apk add --no-cache --update ca-certificates
COPY --from=builder /ingress-jwt-auth /ingress-jwt-auth
ENTRYPOINT ["/ingress-jwt-auth"]
