# Stage 1: Build the Astro site using Bun
FROM bunsh/bun:latest AS builder

WORKDIR /app

# Copy package.json, bun.lockb, and install dependencies with Bun
COPY package.json bun.lockb ./
RUN bun install

# Copy the rest of the source code
COPY . ./

# Build the Astro project using Bun
RUN bun run astro build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the built static files from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 for Nginx
EXPOSE 80
