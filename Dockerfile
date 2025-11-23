# Use official Node.js image for building the app
FROM node:22-alpine AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY my-react-app/package*.json ./

# Install dependencies
RUN npm install

# Copy all source files
COPY my-react-app/ ./

# Build the project
RUN npm run build

# Use a lightweight web server for production
FROM nginx:stable-alpine

# Copy built files to nginx html folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

