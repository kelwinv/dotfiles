# 🚀 Guia Rápido de Comandos

Referência rápida dos comandos mais usados para cada stack.

## 📗 Node.js / TypeScript / React

### Gerenciamento de Projetos
```bash
# Criar novo projeto React com Vite
crv                              # Alias para npm create vite@latest
pnpm create vite my-app          # Manual

# Instalar dependências
pi                               # pnpm install
ni                               # npm install
yi                               # yarn install

# Adicionar pacotes
pa react-router-dom              # pnpm add
pad @types/node                  # pnpm add -D (dev dependency)

# Executar projeto
pd                               # pnpm dev
nd                               # npm run dev
yd                               # yarn dev
```

### Comandos Comuns
```bash
# Build
pb                               # pnpm build
nb                               # npm run build

# Testes
pt                               # pnpm test
nt                               # npm test

# Atualizar dependências
pu                               # pnpm update
nu                               # npm update

# Listar pacotes desatualizados
nout                             # npm outdated
```

### TypeScript
```bash
tsc                              # Compilar TypeScript
tsx src/index.ts                 # Executar com tsx
```

## 🐍 Python

### Gerenciamento de Projetos
```bash
# Criar novo projeto com Poetry
init-python my-project           # Função customizada

# Ou manual:
mkdir my-project && cd my-project
poetry init

# Criar virtual environment (alternativa)
venv                             # python -m venv venv
activate                         # source venv/bin/activate
```

### Poetry (Recomendado)
```bash
# Instalar dependências
poi                              # poetry install

# Adicionar pacotes
poa fastapi                      # poetry add
poad pytest                      # poetry add --group dev

# Executar comandos
por python main.py               # poetry run
pos                              # poetry shell (ativar ambiente)

# Atualizar
pou                              # poetry update
```

### pip (Tradicional)
```bash
pipi fastapi                     # pip install
pipir                            # pip install -r requirements.txt
pipf                             # pip freeze > requirements.txt
pipu                             # pip install --upgrade pip
```

### Django
```bash
djrun                            # python manage.py runserver
djmm                             # python manage.py makemigrations
djm                              # python manage.py migrate
djsh                             # python manage.py shell
djsu                             # python manage.py createsuperuser
```

### Jupyter
```bash
jn                               # jupyter notebook
jl                               # jupyter lab
```

## ⚡ .NET / C#

### Criar Projetos
```bash
# Tipos de projeto
dn-console MyApp                 # Console application
dn-api MyAPI                     # Web API
dn-web MyWeb                     # Web application
dn-mvc MyMVC                     # MVC application
dn-react MyReact                 # React + ASP.NET
dn-blazor MyBlazor               # Blazor Server
dn-lib MyLib                     # Class library
dn-test MyTests                  # xUnit test project
```

### Comandos de Desenvolvimento
```bash
# Executar
dr                               # dotnet run
dw                               # dotnet watch run (hot reload)

# Build e Clean
db                               # dotnet build
dc                               # dotnet clean

# Testes
dt                               # dotnet test

# Publicar
dp                               # dotnet publish
```

### Gerenciamento de Pacotes
```bash
# Adicionar/Remover
dna Newtonsoft.Json              # dotnet add package
dnrm Newtonsoft.Json             # dotnet remove package

# Listar
dnl                              # dotnet list package
dnout                            # dotnet list package --outdated
```

### Entity Framework
```bash
ef                               # dotnet ef
efm InitialCreate                # dotnet ef migrations add
efu                              # dotnet ef database update
efd                              # dotnet ef database drop
```

### User Secrets
```bash
dns                              # dotnet user-secrets
dnss "ApiKey" "secret123"        # dotnet user-secrets set
dnsl                             # dotnet user-secrets list
```

## 🐳 Docker

### Containers
```bash
# Listar e gerenciar
dps                              # docker ps (rodando)
dpsa                             # docker ps -a (todos)
dstop container_id               # Parar
dstart container_id              # Iniciar
drestart container_id            # Reiniciar
drm container_id                 # Remover
drm $(docker ps -aq)             # Remover todos

# Executar
drun ubuntu bash                 # Interativo
drund -p 3000:3000 myapp         # Detached com porta
dex container_id bash            # Entrar no container

# Logs e debug
dlog container_id                # Ver logs
dins container_id                # Inspecionar
dstats                           # Ver recursos
dtop container_id                # Processos
```

### Imagens
```bash
di                               # Listar imagens
db myapp:1.0 .                   # Build
docker push myapp:1.0            # Push
docker pull ubuntu:22.04         # Pull
drmi image_id                    # Remover
diprune                          # Limpar não usadas
```

### Volumes e Networks
```bash
dvol                             # Listar volumes
dvprune                          # Limpar volumes
dnet                             # Listar networks
dnetins network_name             # Inspecionar network
```

### Limpeza
```bash
dprune                           # Limpar TUDO (cuidado!)
docker container prune           # Limpar containers
diprune                          # Limpar imagens
dvprune                          # Limpar volumes
```

## 🐳 Docker Compose

### Comandos Básicos
```bash
# Subir/Parar
dcu                              # docker-compose up
dcud                             # docker-compose up -d
dcd                              # docker-compose down
dcd -v                           # down + remover volumes

# Gerenciar
dcr                              # Reiniciar todos
dcr service_name                 # Reiniciar um serviço
dcps                             # Ver status
dcl                              # Logs de todos
dcl service_name                 # Logs de um serviço

# Build e Pull
dcb                              # Build todos
dcb --no-cache                   # Build sem cache
dcpull                           # Pull de imagens

# Executar comandos
dce service_name bash            # Entrar no container
dce api npm run migrate          # Executar comando

# Escalar
docker-compose up -d --scale api=3
```

## ☸️ Kubernetes

### Recursos Básicos
```bash
# Get (listar)
kgp                              # Get pods
kgp -o wide                      # Com mais info
kgp -A                           # Todos namespaces
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
kl pod-name -c container         # Container específico
```

### Apply e Delete
```bash
kaf deployment.yaml              # Aplicar arquivo
kaf .                            # Aplicar diretório
kdf deployment.yaml              # Deletar por arquivo
kdel pod pod-name                # Deletar pod
kdel deployment deploy-name      # Deletar deployment
```

### Exec e Port Forward
```bash
kex pod-name -- ls /app          # Executar comando
kbash pod-name                   # Bash interativo
ksh pod-name                     # Shell interativo
kpf pod-name 8080:80             # Port forward
kpf service/myapp 8080:80        # Forward de service
```

### Scaling e Updates
```bash
kscale deployment myapp --replicas=5
krollout status deployment/myapp
krollout history deployment/myapp
krollback deployment/myapp       # Desfazer deploy
krollout restart deployment/myapp
ked deployment myapp             # Editar
```

### Context e Namespace
```bash
kgctx                            # Listar contexts
kctx                             # Trocar context
kusecontext minikube             # Usar context
kcurrent                         # Context atual

kgns                             # Listar namespaces
kns production                   # Trocar namespace
```

### Recursos e Debug
```bash
ktop                             # Uso de recursos
ktopp                            # Top pods
ktopn                            # Top nodes
kubectl get events               # Ver eventos
kubectl cluster-info             # Info do cluster
```

## 🎯 Helm

### Comandos Básicos
```bash
# Repositórios
hrepo add bitnami https://charts.bitnami.com/bitnami
hrepoup                          # Atualizar repos
hsearch bitnami/postgresql       # Buscar chart

# Install/Upgrade
hi myrelease bitnami/postgresql  # Instalar
hup myrelease bitnami/postgresql # Upgrade
huni myrelease                   # Desinstalar

# Listar
hls                              # Releases
hlsa                             # Todos namespaces

# Info
hshow chart bitnami/postgresql   # Ver chart
hshow values bitnami/postgresql  # Ver values
helm get values myrelease        # Values instalados
```

## 🚀 Minikube

```bash
mkstart                          # Iniciar cluster
mkstop                           # Parar
mkdel                            # Deletar
mkstatus                         # Status
mkdash                           # Dashboard web
mkssh                            # SSH no node
mkip                             # Ver IP
mkservice myapp                  # Abrir service
minikube addons enable ingress   # Habilitar addon
```

## 🔍 K9s

```bash
k9                               # Abrir k9s

# Dentro do k9s:
# 0 - Todos namespaces
# : - Modo comando
# / - Filtrar
# l - Logs
# d - Describe
# e - Edit
# ctrl+d - Delete
# ? - Ajuda
```

## 🔧 Git

### Workflow Básico
```bash
gs                               # git status
ga .                             # git add .
gc "feat: nova feature"          # git commit -m
gp                               # git push
gpull                            # git pull --rebase
```

### Branches
```bash
gb                               # git branch (listar)
gcb feature/nova                 # git checkout -b (criar e trocar)
gco main                         # git checkout (trocar)
gbd feature/antiga               # git branch -d (deletar)
```

### Histórico
```bash
glog                             # git log visual
glg                              # git log detalhado
gd                               # git diff
gdc                              # git diff --cached
```

### Desfazer Mudanças
```bash
gundo                            # git reset --soft HEAD^ (último commit)
greset                           # git reset --hard (descartar tudo)
gstash                           # git stash (guardar mudanças)
gstashp                          # git stash pop (recuperar)
```

## 🛠️ Ferramentas Úteis

### Busca e Navegação
```bash
z projects                       # zoxide (cd inteligente)
fzf                              # Ctrl+R (busca no histórico)
rg "search term"                 # ripgrep (busca em arquivos)
fd file.txt                      # fd (find melhorado)
```

### Visualização
```bash
ll                               # exa -lah --icons (ls melhorado)
lt                               # exa --tree (árvore 2 níveis)
cat file.txt                     # bat (cat com highlight)
```

### Sistema
```bash
htop                             # Monitor de processos
ncdu                             # Analisador de disco
ports                            # Ver portas em uso
killport 3000                    # Matar processo na porta
myip                             # Ver IP público
```

### Projetos
```bash
init-node my-project             # Criar projeto Node.js
init-python my-project           # Criar projeto Python
init-dotnet my-project           # Criar projeto .NET
mkcd my-folder                   # mkdir + cd
extract file.zip                 # Extrair arquivo
```

## 📦 Versões de Runtime

### Node.js (NVM)
```bash
nvm ls                           # Listar versões instaladas
nvm install 20                   # Instalar versão
nvm use 20                       # Usar versão
nvm alias default 20             # Definir padrão
```

### Python (pyenv)
```bash
pyenv versions                   # Listar versões instaladas
pyenv install 3.12               # Instalar versão
pyenv global 3.12                # Definir padrão
pyenv local 3.11                 # Versão por projeto
```

### .NET
```bash
dotnet --list-sdks               # Listar SDKs instalados
dotnet --version                 # Versão atual
```

## 🔄 Sincronização

```bash
# Atualizar dotfiles
dotfiles                         # cd ~/dotfiles
dotsync "mensagem"               # Sincronizar com GitHub

# Recarregar shell
reload                           # source ~/.zshrc
zshconfig                        # Editar .zshrc
```

## 💡 Dicas

### Atalhos do Terminal
- `Ctrl+R` - Busca no histórico (com fzf)
- `Ctrl+L` - Limpar tela
- `Ctrl+C` - Cancelar comando
- `Ctrl+D` - Sair do shell
- `Ctrl+A` - Ir ao início da linha
- `Ctrl+E` - Ir ao fim da linha
- `Ctrl+U` - Deletar antes do cursor
- `Ctrl+K` - Deletar depois do cursor
- `Alt+.` - Último argumento do comando anterior

### Truques Git
```bash
!!                               # Repetir último comando
!$                               # Último argumento do último comando
cd -                             # Voltar para diretório anterior
```

### Combos Úteis
```bash
# Ver mudanças antes de commitar
gd && gs

# Build e executar
db && dr

# Instalar e executar
pi && pd

# Limpar tudo e recomeçar
dc && db && dr
```