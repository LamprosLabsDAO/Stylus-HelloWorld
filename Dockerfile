# Use the official Rust image
FROM rust:latest

# Set the working directory inside the container
WORKDIR /app

# Install the required Rust target for compiling to WebAssembly
RUN rustup target add wasm32-unknown-unknown

# Install the Stylus CLI tool
RUN cargo install --force cargo-stylus cargo-stylus-check

# Copy your project files into the Docker container
COPY . .

# Compile the program and check the validity for Stylus without Docker verification
RUN cargo stylus check --no-verify

# Set the default command to deploy, but expect the private key to be provided as an environment variable
CMD ["sh", "-c", "cargo stylus deploy --private-key=${PRIVATE_KEY} --no-verify"]
