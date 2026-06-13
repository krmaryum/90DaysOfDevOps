FROM python:3.11-slim
# Use the official Python 3.11 slim image as the base image (lightweight version)

WORKDIR /app
# Set the working directory inside the container to /app
# All subsequent commands will run inside this directory

COPY requirements.txt .
# Copy the requirements.txt file from the host machine
# into the container's current directory (/app)

RUN pip install --no-cache-dir -r requirements.txt
# Install Python dependencies listed in requirements.txt
# --no-cache-dir prevents pip from storing cache files to keep the image smaller

COPY . .
# Copy the entire project directory from the host machine
# into the container's /app directory

EXPOSE 5000
# Inform Docker that the container will listen on port 5000
# This is commonly used by Flask applications

CMD ["python", "app.py"]
# Define the default command that runs when the container starts
# This launches the Flask application by executing app.py
