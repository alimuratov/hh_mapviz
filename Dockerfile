# ===================================================================
# Stage 1: Define Base Image & Environment
# ===================================================================
# Use a slim, modern, and multi-arch compatible Python base image.
FROM python:3.9-slim-bullseye

# Use LABEL instead of the deprecated MAINTAINER instruction.
LABEL maintainer="Daniel Snider <danielsnider12@gmail.com>"

# Set environment variables and a consistent home directory.
ENV PYTHONUNBUFFERED=1
ENV APP_HOME=/mapproxy
WORKDIR $APP_HOME

# ===================================================================
# Stage 2: Install Dependencies
# ===================================================================
# Install system dependencies in a single layer to optimize image size.
# Use apt-get for C libraries and build tools required by Python packages.
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Build tools for compiling Python packages from source
    build-essential \
    # Required C-libraries for geospatial packages
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    # Required C-libraries for the Pillow imaging package
    libjpeg-dev \
    zlib1g-dev \
    libfreetype6-dev \
    # Clean up the apt cache to keep the final image small.
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages using pip in a separate layer for better caching.
# --no-cache-dir also reduces image size.
RUN pip install --no-cache-dir \
    "Shapely<2.0" \
    Pillow \
    PyYAML \
    lxml \
    MapProxy \
    uwsgi

# ===================================================================
# Stage 3: Add Application Code & Set Permissions
# ===================================================================
# Use COPY for simple file transfers; it's more explicit than ADD.
COPY ./mapproxy.yaml ./start.sh ./

# Create a non-root user for security and assign ownership of the app directory.
# Running containers as a non-root user is a critical security measure.
RUN addgroup --system app && adduser --system --ingroup app app
RUN chown -R app:app $APP_HOME

# Switch to the non-root user.
USER app

# Make the startup script executable.
RUN chmod +x ./start.sh

# ===================================================================
# Stage 4: Define Runtime Configuration
# ===================================================================
# Expose the port that the application will listen on.
EXPOSE 8080

# Use the "exec form" for CMD. This is a best practice that ensures
# signals like `docker stop` are handled correctly by the application.
CMD ["./start.sh"]