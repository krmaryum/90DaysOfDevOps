
# Stage 1: Build dependencies
FROM node:18-alpine AS builder

WORKDIR /app

COPY app/package.json ./

RUN npm install

COPY app/ .

# Stage 2: Production image
FROM node:18-alpine

WORKDIR /app

# Create non-root user
RUN addgroup app && adduser -S -G app app

COPY --from=builder /app /app

RUN npm prune --production

USER app

EXPOSE 3000

CMD ["node", "index.js"]
