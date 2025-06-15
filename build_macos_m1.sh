#!/bin/bash

# Build script for macOS Apple Silicon (M1/M2/M3/M4)
# This script compiles RustDesk Server for aarch64-apple-darwin target

set -e

echo "=== Building RustDesk Server for macOS Apple Silicon ==="

# Check if target is installed
if ! rustup target list --installed | grep -q "aarch64-apple-darwin"; then
    echo "Installing aarch64-apple-darwin target..."
    rustup target add aarch64-apple-darwin
fi

# Set environment variables for cross-compilation
export CC_aarch64_apple_darwin=clang
export CXX_aarch64_apple_darwin=clang++
export AR_aarch64_apple_darwin=ar
export CARGO_TARGET_AARCH64_APPLE_DARWIN_LINKER=clang

# Build for Apple Silicon
echo "Building for aarch64-apple-darwin (Apple Silicon)..."
cargo build --release --target aarch64-apple-darwin

echo "=== Build completed ==="
echo "Binaries are located in: target/aarch64-apple-darwin/release/"
echo ""
echo "Built executables:"
ls -la target/aarch64-apple-darwin/release/hbbs target/aarch64-apple-darwin/release/hbbr target/aarch64-apple-darwin/release/rustdesk-utils 2>/dev/null || echo "Some binaries may not have been built successfully"

echo ""
echo "To run on macOS M-series:"
echo "1. Copy the binaries to your macOS machine"
echo "2. Make them executable: chmod +x hbbs hbbr rustdesk-utils"
echo "3. Run the server: ./hbbs"
echo "4. Run the relay: ./hbbr"
