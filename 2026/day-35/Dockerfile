FROM node:18-alpine

WORKDIR /app

# Create non-root user
RUN addgroup app && adduser -S -G app app

COPY package.json .

# Combine RUN commands
RUN npm install && npm cache clean --force

COPY . .

# Use non-root user
USER app

CMD ["node", "index.js"]

