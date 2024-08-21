# 构建应用
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN [ ! -e ".env" ] && cp .env.example .env || true
RUN npm run build

# 最小化镜像
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
RUN npm install -g http-server

EXPOSE 8080
CMD ["http-server", "dist", "-p", "8080"]