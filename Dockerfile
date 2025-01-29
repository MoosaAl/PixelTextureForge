# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install pipenv
RUN pip install pipenv

COPY Pipfile ./
RUN pipenv install

COPY /src ./


# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run the application
ENTRYPOINT ["pipenv", "run"]
CMD ["gunicorn", "--config", "gunicorn_config.py", "app:app"]