# Dockerfile

FROM python:3.11-slim

WORKDIR /app

# Copy API source files
COPY ./api ./api
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the API port
EXPOSE 5000

# Run the Flask API
CMD ["python", "api/app.py"]