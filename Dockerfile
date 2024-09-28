# Base stage
FROM node:21 AS base
WORKDIR /app
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN npm install -g pnpm
RUN pnpm install
VOLUME node-modules-root
VOLUME node_modules_api
VOLUME node_modules_web
VOLUME next_web

# Builder stage
FROM base AS builder
WORKDIR /app
COPY . .
RUN pnpm install

# Runner stage for web
FROM node:21 AS runner-web
WORKDIR /app
COPY --from=builder /app .
COPY .env.dev ./app/.env
WORKDIR /app/apps/web
RUN npm install -g pnpm
EXPOSE 3000
CMD ["pnpm", "dev"]

# Runner stage for API
FROM node:21 AS runner-api
WORKDIR /app
COPY --from=builder /app .
COPY .env.dev ./app/.env
WORKDIR /app/apps/api
RUN npm install -g pnpm
RUN pnpm prisma generate
EXPOSE 3333
CMD ["pnpm", "dev"]
