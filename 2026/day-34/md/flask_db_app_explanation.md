# Flask Application with PostgreSQL -- Line‑by‑Line Explanation

This document explains a simple Flask application that connects to a
PostgreSQL database and reports whether the connection is successful.

------------------------------------------------------------------------

# Application Code

``` python
from flask import Flask
import psycopg2
import os

app = Flask(__name__)

db_host = os.getenv("DB_HOST", "db")

def check_db():
    try:
        conn = psycopg2.connect(
            host=db_host,
            database="appdb",
            user="postgres",
            password="postgres"
        )
        conn.close()
        return "Database Connected"
    except Exception as e:
        return f"Database Error: {e}"

@app.route("/")
def home():
    db_status = check_db()
    return f"Hello from Flask!<br>{db_status}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

------------------------------------------------------------------------

# Line‑by‑Line Explanation

## Import Flask

``` python
from flask import Flask
```

This imports the **Flask class** from the Flask library.\
Flask is a lightweight web framework used to build web applications and
APIs.

------------------------------------------------------------------------

## Import PostgreSQL Adapter

``` python
import psycopg2
```

This imports **psycopg2**, a PostgreSQL adapter for Python.

It allows the application to:

-   connect to PostgreSQL
-   execute SQL queries
-   interact with database data

------------------------------------------------------------------------

## Import OS Module

``` python
import os
```

This imports Python's built‑in **os module**.

It is used to read **environment variables**, which are often used for
configuration in Docker containers.

------------------------------------------------------------------------

## Create the Flask App

``` python
app = Flask(__name__)
```

This creates the **Flask application instance**.

-   `app` represents the web application.
-   `__name__` helps Flask determine the location of the application.

------------------------------------------------------------------------

## Read Database Host Environment Variable

``` python
db_host = os.getenv("DB_HOST", "db")
```

This reads the environment variable **DB_HOST**.

If the variable does not exist, the default value `"db"` is used.

This is useful when running in Docker Compose where the database
container is named **db**.

------------------------------------------------------------------------

# Database Connection Function

## Function Definition

``` python
def check_db():
```

Defines a function that attempts to connect to the PostgreSQL database.

The function returns a status message indicating whether the connection
succeeded.

------------------------------------------------------------------------

## Try Block

``` python
try:
```

Starts a **try block**.

The code inside it will attempt to run normally.

If an error occurs, Python will jump to the `except` block.

------------------------------------------------------------------------

## Connect to PostgreSQL

``` python
conn = psycopg2.connect(
```

This creates a **database connection** using the psycopg2 library.

------------------------------------------------------------------------

### Database Host

``` python
host=db_host,
```

Uses the value stored in the `db_host` variable.

In Docker environments, this usually points to the **db container**.

------------------------------------------------------------------------

### Database Name

``` python
database="appdb",
```

Specifies the PostgreSQL database name the application should connect
to.

------------------------------------------------------------------------

### Database User

``` python
user="postgres",
```

Defines the PostgreSQL username used to authenticate the connection.

------------------------------------------------------------------------

### Database Password

``` python
password="postgres"
```

Defines the password used for the database connection.

Note: This is acceptable for development but **not recommended for
production environments**.

------------------------------------------------------------------------

## Close the Connection

``` python
conn.close()
```

Closes the database connection after successfully verifying it works.

------------------------------------------------------------------------

## Success Message

``` python
return "Database Connected"
```

If the connection succeeds, the function returns a success message.

------------------------------------------------------------------------

## Exception Handling

``` python
except Exception as e:
```

If an error occurs during the connection attempt, execution moves to
this block.

`e` stores the error message.

------------------------------------------------------------------------

## Error Message

``` python
return f"Database Error: {e}"
```

Returns a formatted string containing the database connection error.

------------------------------------------------------------------------

# Flask Route

## Route Definition

``` python
@app.route("/")
```

This is a Flask **route decorator**.

It tells Flask that the function below handles requests to the homepage
`/`.

------------------------------------------------------------------------

## Route Function

``` python
def home():
```

Defines the function that executes when someone visits the root URL.

------------------------------------------------------------------------

## Call Database Check

``` python
db_status = check_db()
```

Calls the `check_db()` function and stores the result in `db_status`.

------------------------------------------------------------------------

## Return Response

``` python
return f"Hello from Flask!<br>{db_status}"
```

Returns a simple HTML response containing:

-   a greeting message
-   the database connection status

`<br>` creates a line break in the browser.

------------------------------------------------------------------------

# Run the Application

## Entry Point Check

``` python
if __name__ == "__main__":
```

This ensures the application runs only when the file is executed
directly.

------------------------------------------------------------------------

## Start Flask Server

``` python
app.run(host="0.0.0.0", port=5000)
```

Starts the Flask development server.

-   `host="0.0.0.0"` allows connections from outside the container
-   `port=5000` runs the application on port 5000

This is required when running the application inside a **Docker
container**.

------------------------------------------------------------------------

# Application Architecture

    Browser
       │
       ▼
    Flask Web App
       │
       ▼
    PostgreSQL Database

The Flask application receives requests, checks the database connection,
and returns the status to the user.
