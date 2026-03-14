from flask import Flask                                 # Import the Flask class used to create the web application

import psycopg2                                         # Import psycopg2 so Python can connect to PostgreSQL

import os                                               # Import the os module to read environment variables

app = Flask(__name__)                                   # Create the Flask application instance

db_host = os.getenv("DB_HOST", "db")                    # Read the DB_HOST environment variable,If DB_HOST is not set, use "db" as the default hostname

def check_db():                                         # Define a function that checks whether PostgreSQL is reachable
    try:                                                # Try to connect to the PostgreSQL database
        conn = psycopg2.connect(                        # Open a database connection using the settings below
            host=db_host,                               # Use the database host from the environment or the default value
            database="appdb",                           # Connect to the database named appdb
            user="postgres",                            # Use postgres as the database username
            password="postgres"                         # Use postgres as the database password
        )
        conn.close()                                    # Close the connection immediately after testing it
        return "Database Connected"                     # Return a success message if the connection works
    except Exception as e:                              # Catch any database connection error
        return f"Database Error: {e}"                   # Return the error message as text

@app.route("/")                                         # Register the home page route so this function handles requests to "/"
def home():                                             # Define the function for the home page
    db_status = check_db()                              # Call the database check function and store the result
    return f"Hello from Flask!\n{db_status}\n"          # Return a simple HTML response with a greeting and database status

if __name__ == "__main__":                              # Check whether this file is being run directly
    app.run(host="0.0.0.0", port=5000)                  # Start the Flask app on all network interfaces at port 5000

