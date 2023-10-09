#!/bin/bash
# Update packages
sudo apt-get update -y

# Install Node.js and npm
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt-get install -y nodejs

# Install git to clone the repository
sudo apt-get install -y git

# Clone your Node.js app repository
sudo -u ubuntu git clone https://github.com/duyenlegit/nodejs_aws.git /home/ubuntu/your-nodejs-app

# Install Docker
curl -fsSL https://get.docker.com | sudo sh

# Add the current user to the Docker group (only needed if you want to run Docker commands without sudo)
sudo usermod -aG docker ubuntu

# Install dependencies and start the application
cd /home/ubuntu/your-nodejs-app
sudo docker build -t your-nodejs-app-image .
#sudo -u ubuntu npm install
#sudo -u ubuntu npm start &

# Run the Docker container
sudo docker run -d --name your-nodejs-app-container -p 3000:3000 your-nodejs-app-image