# Use the latest Python LTS image (Python 3.12)
FROM python:3.12-slim

# Prevent Python from writing .pyc files and enable stdout logging
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy and install dependencies first to leverage Docker cache
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the application code
COPY . /app/

# Expose the port your app runs on
EXPOSE 5555

# Start the Flask application using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5555", "wsgi:app"]
