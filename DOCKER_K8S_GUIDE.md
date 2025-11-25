# 🐳 Guia Completo: Docker & Kubernetes

## 📦 Docker

### Comandos Básicos

#### Containers
```bash
# Listar containers
dps                              # Rodando
dpsa                             # Todos

# Executar container
drun ubuntu bash                 # Interativo
drund -p 3000:3000 myapp         # Detached com porta

# Gerenciar containers
dstop container_id               # Parar
dstart container_id              # Iniciar
drestart container_id            # Reiniciar
drm container_id                 # Remover
drm $(docker ps -aq)             # Remover todos

# Executar comando em container rodando
dex container_id bash            # Entrar no container
dex container_id ls /app         # Executar comando

# Logs
dlog container_id                # Ver logs
docker logs -f --tail 100 id     # Últimas 100 linhas
```

#### Imagens
```bash
# Listar imagens
di                               # docker images

# Build
db myapp:1.0 .                   # Buildar imagem
docker build -t myapp:latest --no-cache .

# Push/Pull
docker push myapp:1.0
docker pull ubuntu:22.04

# Remover
drmi image_id                    # Remover imagem
diprune                          # Remover imagens não usadas
```

#### Volumes
```bash
# Listar volumes
dvol                             # docker volume ls

# Criar volume
docker volume create mydata

# Usar volume
docker run -v mydata:/app/data myapp

# Remover volumes não usados
dvprune                          # docker volume prune -f
```

#### Networks
```bash
# Listar networks
dnet                             # docker network ls

# Criar network
docker network create mynetwork

# Conectar container
docker network connect mynetwork container_id
```

#### Inspeção e Debug
```bash
dins container_id                # Inspecionar container
dstats                           # Ver uso de recursos
dtop container_id                # Processos no container
docker diff container_id         # Ver mudanças no filesystem
```

#### Limpeza
```bash
dprune                           # Limpar tudo (cuidado!)
docker system df                 # Ver espaço usado
docker container prune           # Limpar containers parados
dvprune                          # Limpar volumes não usados
diprune                          # Limpar imagens não usadas
```

### Dockerfile - Boas Práticas

#### Node.js
```dockerfile
# Multi-stage build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

#### Python
```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

#### .NET
```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["MyApp.csproj", "./"]
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "MyApp.dll"]
```

### .dockerignore
```
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.DS_Store
dist
build
coverage
*.log
.vscode
.idea
__pycache__
*.pyc
bin/
obj/
```

## 🐳 Docker Compose

### Comandos Básicos
```bash
# Subir serviços
dcu                              # docker-compose up
dcud                             # docker-compose up -d (detached)
dcu --build                      # Rebuildar antes de subir

# Parar serviços
dcd                              # docker-compose down
docker-compose down -v           # Remover volumes também

# Gerenciar
dcr                              # Reiniciar
dcr service_name                 # Reiniciar serviço específico
dcps                             # Ver status
dcl                              # Logs de todos
dcl service_name                 # Logs de um serviço

# Build
dcb                              # Build todos
dcb service_name                 # Build específico
dcb --no-cache                   # Build sem cache

# Executar comandos
dce service_name bash            # Entrar no container
dce api npm run migrate          # Executar comando

# Escalar serviços
docker-compose up -d --scale api=3

# Pull de imagens
dcpull                           # Atualizar imagens
```

### Exemplo Completo
```yaml
version: '3.8'

services:
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
      args:
        - NODE_ENV=development
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
      - /app/node_modules
    environment:
      - VITE_API_URL=http://localhost:4000
    networks:
      - app-network
    depends_on:
      - backend

  backend:
    build: ./backend
    ports:
      - "4000:4000"
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/mydb
      - REDIS_URL=redis://redis:6379
    volumes:
      - ./backend:/app
      - /app/node_modules
    networks:
      - app-network
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started

  db:
    image: postgres:16-alpine
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=pass
      - POSTGRES_DB=mydb
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data
    networks:
      - app-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    networks:
      - app-network

networks:
  app-network:
    driver: bridge

volumes:
  db_data:
  redis_data:
```

## ☸️ Kubernetes

### kubectl - Comandos Essenciais

#### Recursos Básicos
```bash
# Get (listar)
kgp                              # Get pods
kgp -o wide                      # Com mais informações
kgp -A                           # Todos os namespaces
kgs                              # Get services
kgd                              # Get deployments
kgn                              # Get nodes
kga                              # Get all

# Describe (detalhes)
kdp pod-name                     # Describe pod
kds service-name                 # Describe service
kdd deployment-name              # Describe deployment

# Logs
kl pod-name                      # Logs
klf pod-name                     # Logs -f (follow)
kl pod-name -c container-name    # Logs de container específico
kl pod-name --previous           # Logs do container anterior
```

#### Apply e Delete
```bash
# Apply
kaf deployment.yaml              # Aplicar arquivo
kaf .                            # Aplicar todos YAML do diretório
kubectl apply -k ./kustomize     # Kustomize

# Delete
kdf deployment.yaml              # Deletar por arquivo
kdel pod pod-name                # Deletar pod
kdel deployment deploy-name      # Deletar deployment
kubectl delete all --all         # Deletar tudo (cuidado!)
```

#### Exec e Port Forward
```bash
# Executar comandos
kex pod-name -- ls /app          # Executar comando
kbash pod-name                   # Bash interativo
ksh pod-name                     # Shell interativo

# Port forward
kpf pod-name 8080:80             # Forward porta
kpf service/myapp 8080:80        # Forward de service
```

#### Scaling e Updates
```bash
# Scale
kscale deployment myapp --replicas=5

# Rollout
krollout status deployment/myapp
krollout history deployment/myapp
krollback deployment/myapp       # Desfazer último deploy
krollout restart deployment/myapp

# Edit
ked deployment myapp             # Editar deployment
kubectl edit pod pod-name        # Editar pod
```

#### Context e Namespace
```bash
# Context
kgctx                            # Listar contexts
kctx                             # Trocar context (kubectx)
kusecontext minikube             # Usar context
kcurrent                         # Ver context atual

# Namespace
kgns                             # Listar namespaces
kns production                   # Trocar namespace (kubens)
kubectl config set-context --current --namespace=production
```

#### Recursos e Debug
```bash
# Top (uso de recursos)
ktop                             # Visão geral
ktopp                            # Top pods
ktopn                            # Top nodes

# Debug
kubectl get events               # Ver eventos
kubectl cluster-info             # Info do cluster
kubectl api-resources            # Listar recursos disponíveis
kubectl explain pod              # Documentação de recurso
```

### Manifests - Estrutura Básica

#### Deployment Completo
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  namespace: production
  labels:
    app: myapp
    version: v1
spec:
  replicas: 3
  revisionHistoryLimit: 10
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
        version: v1
    spec:
      serviceAccountName: myapp-sa
      containers:
      - name: myapp
        image: myapp:1.0.0
        imagePullPolicy: Always
        ports:
        - name: http
          containerPort: 3000
          protocol: TCP
        env:
        - name: NODE_ENV
          value: "production"
        - name: DB_HOST
          valueFrom:
            configMapKeyRef:
              name: myapp-config
              key: db_host
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: myapp-secrets
              key: db_password
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 3
        volumeMounts:
        - name: config
          mountPath: /app/config
          readOnly: true
        - name: data
          mountPath: /app/data
      volumes:
      - name: config
        configMap:
          name: myapp-config
      - name: data
        persistentVolumeClaim:
          claimName: myapp-pvc
```

## 🎯 Helm

### Comandos Básicos
```bash
# Repositórios
hrepo add bitnami https://charts.bitnami.com/bitnami
hrepoup                          # Atualizar repos
hrepo list                       # Listar repos
hsearch bitnami/postgresql       # Buscar chart

# Install/Upgrade
hi myrelease bitnami/postgresql  # Instalar
hi myrelease ./mychart           # Chart local
hup myrelease bitnami/postgresql # Upgrade

# Listar e Remover
hls                              # Releases
hlsa                             # Todos namespaces
huni myrelease                   # Desinstalar

# Info
hshow chart bitnami/postgresql   # Ver chart
hshow values bitnami/postgresql  # Ver values
helm get values myrelease        # Values instalados
helm get manifest myrelease      # Manifests gerados

# Debug
helm template myrelease ./mychart # Gerar manifests
helm lint ./mychart              # Validar chart
```

### Criar Chart
```bash
helm create mychart
cd mychart
# Estrutura:
# Chart.yaml - Metadados
# values.yaml - Valores padrão
# templates/ - Templates K8s
# charts/ - Dependências
```

## 🚀 Minikube

### Comandos Básicos
```bash
# Gerenciar cluster
mkstart                          # Iniciar
mkstart --driver=docker          # Com driver específico
mkstop                           # Parar
mkdel                            # Deletar
mkstatus                         # Status

# Acessar
mkdash                           # Dashboard web
mkssh                            # SSH no node
mkip                             # Ver IP

# Addons
minikube addons list             # Listar addons
minikube addons enable ingress   # Habilitar ingress
minikube addons enable metrics-server

# Services
mkservice myapp                  # Abrir service no browser
mkservice myapp --url            # Ver URL do service

# Docker
eval $(minikube docker-env)      # Usar Docker do minikube
```

## 🔍 k9s - Dashboard Interativo

```bash
k9                               # Abrir k9s

# Atalhos dentro do k9s:
# 0 - Ver todos namespaces
# : - Modo comando
# / - Filtrar
# l - Logs
# d - Describe
# e - Edit
# y - YAML
# shift+f - Port forward
# ctrl+d - Delete
# ? - Ajuda
```

## 💡 Dicas e Truques

### Docker
```bash
# Copiar arquivo de/para container
docker cp container_id:/path/file.txt ./
docker cp ./file.txt container_id:/path/

# Ver mudanças no container
docker diff container_id

# Exportar/Importar imagem
docker save myapp:1.0 | gzip > myapp.tar.gz
docker load < myapp.tar.gz

# Limitar recursos
docker run -m 512m --cpus=1 myapp
```

### Kubernetes
```bash
# Quick pod para debug
kubectl run debug --image=busybox -it --rm -- sh

# Copiar arquivos
kubectl cp pod-name:/path/file.txt ./file.txt

# Proxy API
kubectl proxy
# Acesse: http://localhost:8001/api/v1

# Ver manifests de recursos rodando
kubectl get pod pod-name -o yaml

# Deletar pods com erro
kubectl delete pods --field-selector=status.phase=Failed

# Ver recursos mais consumidos
kubectl top pods --all-namespaces | sort -k 3 -nr | head -10
```

### Combinações Úteis
```bash
# Restart todos pods de um deployment
kubectl rollout restart deployment/myapp

# Ver logs de todos pods de um deployment
kubectl logs -f deployment/myapp

# Executar em todos pods
kubectl get pods -o name | xargs -I {} kubectl exec {} -- command

# Watch em recursos
watch kubectl get pods
```