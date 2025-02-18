# Use the latest Python LTS image (Python 3.12)
FROM python:3.12-slim

# Prevent Python from writing .pyc files and enable stdout logging
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy and install dependencies first
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the analytics code
COPY . /app/

# Optionally set an entrypoint or command.
# For example, if you want to run analytics.py:
CMD ["python", "analytics.py"]
