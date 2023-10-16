# Use the official Python image as the builder stage
FROM python:3.8 AS builder

# Create a non-root user
# Create a new group and user with specific UID and GID without interactive prompts
LABEL MAINTAINER="FirstName LastName <example@domain.com>"

RUN apt-get update \
    ## cleanup
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove --purge  -y \
    && rm -rf /var/lib/apt/lists/*

## ----------------------------------------------------------------
## Add venv
## ----------------------------------------------------------------
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY src/app.py .

# Set the environment variable to "Blue" or "Green"
ENV APP_ENV=Green

# Use the official Python image as the final runtime stage
FROM python:3.8-slim

## ----------------------------------------------------------------
## add user so we can run things as non-root
## ----------------------------------------------------------------
RUN useradd flaskuser

## ----------------------------------------------------------------
## Copy from builder and set ENV for venv
## ----------------------------------------------------------------
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Set the working directory
WORKDIR /app

# Copy the application code from the builder stage
COPY --from=builder /app .

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["python", "app.py"]
