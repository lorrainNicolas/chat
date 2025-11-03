# Utiliser Go pour compiler le serveur
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copier tout le code
COPY . .

# Compiler le serveur
RUN go build -o tinode ./server

# Créer l'image finale minimale
FROM alpine:latest
WORKDIR /app

# Copier le serveur compilé
COPY --from=builder /app/tinode ./tinode
COPY --from=builder /app/tinode.conf ./tinode.conf

# Exposer le port
EXPOSE 6060

# Lancer Tinode
CMD ["./tinode", "-config=tinode.conf"]
