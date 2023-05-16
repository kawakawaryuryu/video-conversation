FROM node:18-alpine3.17 as build
LABEL authors="kawakawaryuryu"
WORKDIR /app
COPY package.json /app
COPY package-lock.json /app
RUN npm ci --production
COPY . /app
RUN npm run build

FROM node:18-alpine3.17
WORKDIR /app
COPY --from=build /app/package.json /app
COPY --from=build /app/.next /app
COPY --from=build /app/node_modules /app

CMD ["npm", "start"]
