FROM oven/bun:1 AS builder

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN bun install

COPY . .
RUN bun run build

FROM oven/bun:1 AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000

COPY --from=builder /app/.output ./.output

EXPOSE 3000

CMD ["bun", ".output/server/index.mjs"]
