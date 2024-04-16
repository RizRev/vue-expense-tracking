FROM node:latest as build

WORKDIR /app

COPY package.json .   

RUN npm install

RUN npm audit fix

COPY . .

RUN npm run build           

EXPOSE 8000

CMD [ "npm", "run", "preview" ]
