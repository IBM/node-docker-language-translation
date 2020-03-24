FROM node:10

ENV NODE_CONTAINER_VERSION=1.0.0

# Create directory for application
WORKDIR /data/translator-app

# Install dependencies
COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 8080
CMD [ "node", "server.js" ]
