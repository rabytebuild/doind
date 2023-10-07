# Use an official Ubuntu as the base image
FROM ubuntu:20.04

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    docker.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install easypanel
RUN curl -sSL https://get.easypanel.io | sh

# Expose all required ports. Replace these with the actual required ports.
EXPOSE 80 443 8080 3000

# Set the entry point for your application
ENTRYPOINT ["easypanel/easypanel", "setup"]

# Specify any default command or arguments for the entry point
CMD ["--rm", "-it", "-v", "/etc/easypanel:/etc/easypanel", "-v", "/var/run/docker.sock:/var/run/docker.sock:ro"]
