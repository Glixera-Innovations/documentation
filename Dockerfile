FROM oven/bun:1 AS base
WORKDIR /app

# Install dependencies (including postinstall fumadocs-mdx generation)
FROM base AS deps
COPY package.json bun.lock ./
RUN bunx fumadocs-mdx
RUN bun install --frozen-lockfile

# Build the Next.js application
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN bun run build

# Production runner
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=10000
ENV HOSTNAME="0.0.0.0"

COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

EXPOSE 10000

CMD ["bun", "run", "start"]