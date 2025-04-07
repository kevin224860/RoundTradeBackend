# Backend Dockerfile
FROM python:3.12-slim

# Set working directory
WORKDIR /app

RUN apt-get update && apt-get install -y libpq-dev gcc && rm -rf /var/lib/apt/lists/*

# Copy the requirements.txt and install dependencies
COPY requirements.txt ./
RUN python -m ensurepip --upgrade
RUN pip install --no-cache-dir psycopg2-binary
RUN pip install --no-cache-dir -r requirements.txt

# Copy all files
COPY . .

ARG FRONTEND_URL
ENV FRONTEND_URL=${FRONTEND_URL}

ARG SECRET_KEY
ENV SECRET_KEY=${SECRET_KEY}

ARG HOST
ENV HOST=${HOST}

ARG PORT
ENV PORT=${PORT}

ARG DATABASE
ENV DATABASE=${DATABASE}

ARG USER
ENV USER=${USER}

ARG PASSWORD
ENV PASSWORD=${PASSWORD}

# Expose port for the backend
EXPOSE 5000

# Start the Flask app
CMD ["python", "app.py"]
