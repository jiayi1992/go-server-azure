# Use the official Go image
FROM golang:1.23.4 AS builder

# Set working directory
WORKDIR /app

# Copy and build the Go app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./server

# --- Runtime stage ---
FROM alpine:latest

WORKDIR /root/

# Install libc just in case (optional, not needed with CGO_ENABLED=0)
# RUN apk add --no-cache libc6-compat

COPY --from=builder /app/main .

EXPOSE 8080
CMD ["./main"]
