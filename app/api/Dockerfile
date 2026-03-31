# @req REQ-INFRA-002 Minimal Rust API image with musl
FROM rust:1.91-alpine AS builder

# Install musl target and build dependencies
RUN apk add --no-cache musl-dev openssl-dev && \
    rustup target add x86_64-unknown-linux-musl

WORKDIR /usr/src/app

# Copy manifests first for caching
COPY Cargo.toml Cargo.lock* ./

# Create dummy main.rs to cache dependencies
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --target x86_64-unknown-linux-musl --release
RUN rm -rf srcS

# Copy actual source and rebuild
COPY src ./src
RUN cargo build --target x86_64-unknown-linux-musl --release

# Final stage - alpine with healthcheck support
FROM alpine:latest

# Install runtime dependencies and create non-root user
RUN apk add --no-cache ca-certificates wget && \
    addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

# Copy binary from builder
COPY --from=builder --chown=appuser:appgroup /usr/src/app/target/x86_64-unknown-linux-musl/release/sdd-navigator-api /usr/local/bin/

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1

CMD ["sdd-navigator-api"]
