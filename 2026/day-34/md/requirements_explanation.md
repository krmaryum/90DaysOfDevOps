# requirements.txt Explanation

This document explains the purpose of the **requirements.txt** file used
in the Flask + PostgreSQL + Redis application.

------------------------------------------------------------------------

# File Location

The file is created at:

    2026/day-34/task-1/app/requirements.txt

Contents of the file:

    flask
    psycopg2-binary
    redis

This file lists all **Python dependencies** required by the application.

These dependencies are installed using:

    pip install -r requirements.txt

------------------------------------------------------------------------

# Line-by-Line Explanation

## flask

    flask

This installs the **Flask** package.

Flask is a **Python web framework** used to build web applications and
APIs.

In this project Flask is used to:

-   create the web server
-   handle HTTP requests
-   define routes such as `/` or `/health`
-   return responses to users

Example usage in the application:

``` python
from flask import Flask

app = Flask(__name__)
```

Meaning of this line:

**Install Flask so the Python application can run as a web server.**

------------------------------------------------------------------------

## psycopg2-binary

    psycopg2-binary

This installs the **PostgreSQL adapter for Python**.

It allows Python applications to **connect to a PostgreSQL database**.

In this project it is used to:

-   connect the Flask app to the PostgreSQL container
-   execute SQL queries
-   read and write application data

Example usage:

``` python
import psycopg2

conn = psycopg2.connect(
    host="db",
    database="appdb",
    user="postgres",
    password="postgres"
)
```

Meaning of this line:

**Install the PostgreSQL driver so the Python application can
communicate with the database.**

------------------------------------------------------------------------

## redis

    redis

This installs the **Redis Python client library**.

It allows the Python application to **connect to the Redis service**.

Redis is typically used for:

-   caching frequently accessed data
-   storing temporary data
-   improving application performance
-   session storage or message queues

Example usage:

``` python
import redis

r = redis.Redis(host="redis", port=6379)
```

Meaning of this line:

**Install the Redis client so the Python application can communicate
with the Redis cache.**

------------------------------------------------------------------------

# Summary

    flask            → runs the web application
    psycopg2-binary  → connects Python to PostgreSQL
    redis            → connects Python to Redis

------------------------------------------------------------------------

# Key Idea

The `requirements.txt` file ensures that all required Python packages
are installed automatically when the Docker image is built or when the
application environment is prepared.
