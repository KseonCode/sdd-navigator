# @req REQ-INFRA-002 Multi-stage build for Rust API
FROM rust:1.85-alpine AS builder
RUN apk add --no-cache musl-dev openssl-dev
WORKDIR /usr/src/app
COPY Cargo.toml Cargo.lock* ./
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release
COPY . .
RUN cargo build --release

FROM alpine:latest
RUN apk add --no-cache openssl ca-certificates
COPY --from=builder /usr/src/app/target/release/sdd-navigator-api /usr/local/bin/
EXPOSE 8080
CMD ["sdd-navigator-api"]
