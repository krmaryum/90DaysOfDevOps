# Use lightweight Nginx base image
FROM nginx:alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy our custom HTML file into nginx web directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 (documentation purpose)
EXPOSE 80

# Nginx already has default CMD, so we don't need to define one
