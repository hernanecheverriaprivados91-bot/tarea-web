#Etapa 1: Construir la imagen de Docker
FROM node:22-alpine AS build

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

#Etapa 2: Produccion
FROM nginx:alpine AS production

# Copiar los archivos construidos desde la etapa de construcción
COPY --from=build /app/dist /usr/share/nginx/html

#puerto en el que se ejecutará la aplicación
EXPOSE 80

# Iniciar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
