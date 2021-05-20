FROM node:14-alpine as build
WORKDIR /app
COPY package.json ./
RUN npm install
ARG BACKENDURL
ARG APIKEY
# ENV REACT_APP_BACKENDURL=$BACKENDURL
# ENV REACT_APP_APIKEY=$APIKEY
COPY . /app
RUN npm run build

FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
