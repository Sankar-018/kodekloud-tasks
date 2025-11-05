# Use Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements.txt to container
COPY src/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY src/ .

# Expose port 3003
EXPOSE 3003

# Run the application
CMD ["python", "server.py"]
