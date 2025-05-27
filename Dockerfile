FROM node:22 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

FROM node:22
WORKDIR /app
RUN groupadd -r appuser && useradd -r -g appuser appuser
COPY --from=build /app /app
RUN chown -R appuser:appuser /app
USER appuser
EXPOSE 3000
CMD ["node", "index.js"]
