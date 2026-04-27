# Dockerfile.dev
FROM hexpm/elixir:1.17-erlang-27-debian-bookworm

# Set environment early
ENV MIX_ENV=dev \
    LANG=C.UTF-8

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    git \
    curl \
    inotify-tools \
    nodejs \
    npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Hex and Rebar (required)
RUN mix local.hex --force && \
    mix local.rebar --force

# Set working directory
WORKDIR /app

# Expose Phoenix + LiveReload ports
EXPOSE 4000 4001

# Default command (overridden by docker-compose)
CMD ["bash"]