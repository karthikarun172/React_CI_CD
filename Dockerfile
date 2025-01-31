# Step 1: Build the React app
FROM node:14 AS build

# Set working directory
WORKDIR /app

# Copy the package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the entire app
COPY . .

# Build the React app for production
RUN npm run build

# Step 2: Serve the app with an nginx server
FROM nginx:alpine

WORKDIR /usr/share/nginx/html
RUN rm -rf *
# Copy the built app from the previous step
COPY --from=build /app/build .

# Expose the port the app will run on
EXPOSE 80

ENTRYPOINT [ "nginx","-g","daemon off;" ]

# Start the nginx server

