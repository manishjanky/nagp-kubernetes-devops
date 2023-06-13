FROM node:16-alpine

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Copy app source
COPY index.js ./

EXPOSE 3000
CMD [ "node", "index.js" ]

# docker build . -t manishnagarro/nagp-k8-api-service:v1
# docker build . -t manishnagarro/nagp-k8-api-service
# docker push manishnagarro/nagp-k8-api-service:latest