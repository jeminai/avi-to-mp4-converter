# Dockerfile
FROM ubuntu:22.04

# Install ffmpeg and tools
RUN apt-get update && \
    apt-get install -y ffmpeg dialog bash && \
    apt-get clean

# Create app directory
WORKDIR /app

# Copy batch script
COPY batch_convert.sh /app/batch_convert.sh

# Make the script executable
RUN chmod +x /app/batch_convert.sh

# Default command
CMD ["/app/batch_convert.sh"]
