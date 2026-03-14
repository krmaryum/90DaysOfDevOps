# Stage 1: Build stage
FROM node:18.20.4-alpine3.20 AS builder

WORKDIR /app

COPY package.json ./
RUN npm install

COPY app.js ./

# Stage 2: Runtime
FROM node:18.20.4-alpine3.20

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app/package.json ./
COPY --from=builder /app/app.js ./

USER appuser

CMD ["node", "app.js"]
