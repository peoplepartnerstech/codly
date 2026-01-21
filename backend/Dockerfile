# Build stage
FROM rust:latest as builder

WORKDIR /app

# Install dependencies for building
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy all files
COPY Cargo.toml ./
COPY src ./src

# Build the application
# Cargo.lock will be generated automatically if it doesn't exist
RUN cargo build --release

# Runtime stage
FROM debian:bookworm-slim

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    libpq5 \
    && rm -rf /var/lib/apt/lists/*

# Copy binary from builder
COPY --from=builder /app/target/release/codly-backend /app/codly-backend

# Expose port
EXPOSE 3000

# Run the application
CMD ["./codly-backend"]
