# FROM - Base image
FROM node:18

# WORKDIR - Set working directory inside container
WORKDIR /app

# COPY - Copy package files first (better layer chaching)
COPY package.json .

# RUN - Execute commands during build
RUN npm install

# COPY — Copy remaining files
COPY . .

# EXPOSE - Document the port the app uses
EXPOSE 3000

# CMD - Default command when container runs
CMD ["node", "app.js"]

