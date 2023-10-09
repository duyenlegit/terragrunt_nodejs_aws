# Specify the base image
FROM node:14-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the source code of the application
COPY . .

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]