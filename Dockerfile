# Use the official Apache HTTP server image as the base image
FROM httpd:latest

# Set the working directory inside the container
WORKDIR /usr/local/apache2/htdocs/

# Copy the local index.html file to the Apache document root
COPY index.html .

# Expose port 80 to access the server
EXPOSE 80

# Start the Apache HTTP server
CMD ["httpd-foreground"]
