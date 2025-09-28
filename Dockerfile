FROM node:22
ENV NODE_ENV=development

WORKDIR /usr/src/app/

COPY shared/ ./shared/
COPY turbo.json  ./
COPY package.json ./
COPY pnpm-workspace.yaml ./
COPY services/mailer/package*.json ./services/mailer/
COPY services/mailer/jest.config.js ./services/mailer/
COPY services/mailer/tsconfig.json ./services/mailer/
COPY services/mailer/src ./services/mailer/src/
COPY services/mailer/prisma ./services/mailer/prisma/
COPY services/mailer/__tests__ ./services/mailer/__tests__/
COPY services/mailer/.env ./services/mailer/.env

USER root

RUN apt-get clean && \
    mkdir -p /var/lib/apt/lists/partial && \
    apt-get update && \
    apt-get install -y netcat-openbsd

RUN corepack enable && pnpm install
RUN cd /usr/src/app/services/mailer && npx prisma generate
RUN chown -R node:node /usr/src/app

USER node

EXPOSE 3000

CMD ["pnpm", "--filter", "mailer", "start"]

HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=3 \
  CMD nc -z localhost 3000 || exit 1
