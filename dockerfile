#Etapa 1: Construir la imagen de Docker
FROM node:22-alpine as build

# Establecer el directorio de trabajo
WORKDIR /app

# Instalar pnpm y las dependencias
RUN corepack enable

# Copiar los archivos de dependencia
COPY package*.json pnpm-lock.yaml ./

#Instalar las dependencias
RUN pnpm install --frozen-lockfile

# Copiar el código fuente
COPY . .

#ejecutar el proyecto
RUN pnpm build
