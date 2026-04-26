FROM node:20-alpine AS builder

WORKDIR /app

COPY ../frontend/package*.json ./frontend

RUN cd frontend && npm install

COPY frontend ./frontend
RUN cd frontend && npm run build

WORKDIR /app

COPY backend/package*.json ./backend/

RUN cd backend && npm install

COPY backend ./backend

COPY --from=builder /app/frontend/dist ./frontend/dist

WORKDIR /app/backend

EXPOSE 5000

CMD ["node", "server.js"]

