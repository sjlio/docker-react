FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Second phase: means first block is complete
# copy from "builder" phase as describe above
# anything in "/usr/share/nginx/html" folder will be server as static files
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
