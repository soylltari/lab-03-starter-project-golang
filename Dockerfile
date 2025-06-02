FROM golang:1.21-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

# Loading dependencies
RUN go mod download

COPY . .

RUN go build -o build/fizzbuzz

FROM gcr.io/distroless/static:nonroot

COPY --from=builder /app/build/fizzbuzz /fizzbuzz

EXPOSE 8080

CMD ["./fizzbuzz", "serve"]