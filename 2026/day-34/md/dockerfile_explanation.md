# Dockerfile Explanation (Line-by-Line)

This document explains the following Dockerfile step by step and
includes a version with inline comments for easier study.

``` dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
```

------------------------------------------------------------------------

# Line-by-Line Explanation

## FROM python:3.11-slim

This instruction tells Docker to start building the image from an
existing base image.

-   python → official Python image from Docker Hub
-   3.11 → Python version
-   slim → lightweight version of the image with fewer unnecessary
    packages

This means the container already contains a Python 3.11 runtime
environment.

------------------------------------------------------------------------

## WORKDIR /app

Sets the working directory inside the container to:

/app

Any following instructions such as COPY, RUN, or CMD will run relative
to this directory.

This is similar to running:

cd /app

inside the container.

------------------------------------------------------------------------

## COPY requirements.txt .

Copies the file requirements.txt from your local project directory into
the container.

Destination:

/app/requirements.txt

The dot refers to the current working directory inside the container.

------------------------------------------------------------------------

## RUN pip install --no-cache-dir -r requirements.txt

This command runs during the image build process.

It installs the Python dependencies listed in requirements.txt.

Options:

-   -r requirements.txt → install packages listed in the file
-   --no-cache-dir → prevents pip from storing cache files, reducing
    image size

Example dependencies:

flask\
psycopg2\
redis

------------------------------------------------------------------------

## COPY . .

Copies all files from the current project directory into the container.

Source: your project directory\
Destination: /app

Usually includes:

app.py\
templates/\
static/

------------------------------------------------------------------------

## EXPOSE 5000

Tells Docker the container will listen on port 5000.

Flask applications commonly run on port 5000.

Note: EXPOSE only documents the port. It does not publish it.

Publishing happens with:

    ports:
      - "5000:5000"

------------------------------------------------------------------------

## CMD \["python", "app.py"\]

Defines the default command executed when the container starts.

It runs:

    python app.py

which launches the Flask application.

Important difference:

RUN → executes during image build\
CMD → executes when container starts

------------------------------------------------------------------------

# Dockerfile with Inline Comments

``` dockerfile
FROM python:3.11-slim
# Use the official Python 3.11 slim image as the base image

WORKDIR /app
# Set the working directory inside the container to /app

COPY requirements.txt .
# Copy requirements.txt into the container's /app directory

RUN pip install --no-cache-dir -r requirements.txt
# Install dependencies listed in requirements.txt
# --no-cache-dir reduces image size

COPY . .
# Copy the entire project directory into the container

EXPOSE 5000
# Document that the application runs on port 5000

CMD ["python", "app.py"]
# Default command executed when the container starts
# Runs the Flask application
```

------------------------------------------------------------------------

# Simple Mental Model

FROM → base environment\
WORKDIR → project directory\
COPY → move files into container\
RUN → install dependencies\
EXPOSE → document port\
CMD → start application

------------------------------------------------------------------------

# Key Takeaway

This Dockerfile:

-   Uses a lightweight Python base image
-   Creates a working directory
-   Installs dependencies
-   Copies application code
-   Exposes the Flask port
-   Runs the Flask application
