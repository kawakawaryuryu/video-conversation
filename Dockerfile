FROM node:18-alpine3.17 as build
LABEL authors="kawakawaryuryu"
WORKDIR /build
COPY package.json /build
COPY package-lock.json /build
RUN npm ci --production
COPY . /build
RUN npm run build

FROM node:18-alpine3.17
WORKDIR /app
COPY --from=build /build/package.json /app
COPY --from=build /build/.next /app/.next
COPY --from=build /build/node_modules /app/node_modules

CMD ["npm", "start"]
