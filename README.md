# Formtacular

A form submission service that collects user responses and analyzes for spam.

## Configuration

This application is configured via the following environment variables:

    DATABASE_URL = The database url to connect to in production
    POOL_SIZE = The number of connections in the db connection pool
    PORT = The port to run the web server on.
    SECRET_KEY_BASE = Phoenix secret key. Can generate using `mix phoenix.gen.secret`
    SENDGRID_API_KEY = Api key for sending emails through sendgrid

