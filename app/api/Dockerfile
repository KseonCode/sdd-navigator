# @req REQ-INFRA-002 Optimized Rust API Image with Alpine
FROM rust:1.91-alpine AS builder

# Устанавливаем musl и OpenSSL для статической сборки
RUN apk add --no-cache musl-dev openssl-dev openssl-libs-static && \
    rustup target add x86_64-unknown-linux-musl

WORKDIR /usr/src/app

# Копируем зависимости
COPY Cargo.toml Cargo.lock* ./
COPY src ./src

# Собираем статический бинарник для musl
RUN cargo build --target x86_64-unknown-linux-musl --release && \
    strip target/x86_64-unknown-linux-musl/release/sdd-navigator-api

FROM alpine:latest

# Устанавливаем ca-certificates и создаем пользователя
RUN apk add --no-cache ca-certificates && \
    addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

# Копируем бинарник
COPY --from=builder --chown=appuser:appgroup \
    /usr/src/app/target/x86_64-unknown-linux-musl/release/sdd-navigator-api \
    /usr/local/bin/

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD wget -q --spider http://localhost:8080/health || exit 1

CMD ["sdd-navigator-api"]
