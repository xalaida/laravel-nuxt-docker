# Specify base image
FROM node:21-slim

# Specify working directory
WORKDIR /app

# Copy application files
COPY . .

# Install build dependencies
RUN npm install --non-interactive

# Run build
RUN npm run build

# Specify host variable
ENV HOST 0.0.0.0

# Expose Nuxt port
EXPOSE 3000

# Specify image command
CMD ["node", ".output/server/index.mjs"]
