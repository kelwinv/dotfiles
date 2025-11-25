# 🚀 Meus Dotfiles

Configurações pessoais para desenvolvimento Full Stack no Windows + WSL2.

## 📋 Stack Principal

1. **Node.js/TypeScript + React** 🟢
2. **Python** 🐍
3. **.NET/C#** ⚡
4. **Docker + Kubernetes** 🐳☸️

## 🛠️ Ferramentas Incluídas

### Shells & Ambiente
- **Zsh** + Oh My Zsh + Powerlevel10k
- **Windows Terminal** configurado
- **VSCode** otimizado para todas as stacks

### Node.js/TypeScript/React
- **NVM** - Node Version Manager
- **pnpm** - Gerenciador de pacotes rápido
- **yarn** - Gerenciador alternativo
- **TypeScript** + tsx
- **ESLint** + Prettier
- **Create React App** + Vite

### Python
- **pyenv** - Python Version Manager
- **Poetry** - Gerenciador de dependências
- **pipx** - Instalador de ferramentas Python
- **Black** - Code formatter
- **Ruff** - Linter ultra-rápido
- **mypy** - Type checker
- **IPython** - REPL melhorado

### .NET/C#
- **.NET 8 SDK**
- **C# Dev Kit** (VSCode)
- Extensões e configurações otimizadas

### DevOps & Ferramentas
- **Docker** + Docker Compose
- **Kubernetes** (kubectl, helm, k9s, kubectx/kubens)
- **Minikube** - Kubernetes local
- **GitHub CLI** (gh)
- **Git** configurado com aliases
- Ferramentas CLI modernas (exa, bat, fzf, ripgrep, etc.)

## 📦 Instalação Rápida

```bash
# Clonar o repositório
git clone https://github.com/SEU_USUARIO/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Dar permissão de execução
chmod +x install.sh

# Executar instalação (vai instalar TUDO)
./install.sh
```

**Tempo estimado:** 10-15 minutos (depende da conexão)

## 🔧 Instalação Manual por Stack

### Apenas Node.js
```bash
# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
source ~/.zshrc
nvm install --lts
npm install -g pnpm yarn typescript
```

### Apenas Python
```bash
# pyenv
curl https://pyenv.run | bash
source ~/.zshrc
pyenv install 3.12
pyenv global 3.12

# Poetry
curl -sSL https://install.python-poetry.org | python3 -
```

### Apenas .NET
```bash
# .NET 8 SDK
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install -y dotnet-sdk-8.0
```

## 📝 Plugins Zsh Incluídos

- `git` - Aliases para Git
- `node` - Completions para Node.js
- `npm` - Completions para npm
- `yarn` - Completions para Yarn
- `python` - Completions para Python
- `pip` - Completions para pip
- `dotnet` - Completions para .NET CLI
- `docker` - Completions para Docker
- `docker-compose` - Completions para Docker Compose
- `kubectl` - Completions para Kubernetes
- `helm` - Completions para Helm
- `minikube` - Completions para Minikube
- `zsh-autosuggestions` - Sugestões baseadas no histórico
- `zsh-syntax-highlighting` - Destaque de sintaxe
- `zsh-completions` - Completions adicionais
- `history-substring-search` - Busca no histórico
- `colored-man-pages` - Man pages coloridas

## ⚡ Aliases Úteis

### Node.js/JavaScript
```bash
# npm
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nr='npm run'
alias ns='npm start'
alias nt='npm test'

# pnpm
alias pi='pnpm install'
alias pa='pnpm add'
alias pr='pnpm run'
alias pd='pnpm dev'

# yarn
alias ya='yarn add'
alias yr='yarn run'
alias yd='yarn dev'

# React
alias cra='npx create-react-app'
alias crv='npm create vite@latest'
```

### Python
```bash
# Python virtual env
alias venv='python -m venv venv'
alias activate='source venv/bin/activate'

# Poetry
alias po='poetry'
alias poi='poetry install'
alias poa='poetry add'
alias por='poetry run'
alias pos='poetry shell'

# Python
alias py='python3'
alias ipy='ipython'
alias pyserver='python -m http.server'
```

### .NET
```bash
dn      # dotnet new
dr      # dotnet run
db      # dotnet build
dt      # dotnet test
dw      # dotnet watch run
dc      # dotnet clean
dp      # dotnet publish
dna     # dotnet add package
dnl     # dotnet list package
dnu     # dotnet user-secrets
```

### Docker
```bash
dps     # docker ps
di      # docker images
dex     # docker exec -it
dc      # docker-compose
dcu     # docker-compose up
dcd     # docker-compose down
dprune  # limpar tudo
```

### Kubernetes
```bash
k       # kubectl
kgp     # kubectl get pods
kgs     # kubectl get services
kl      # kubectl logs
kex     # kubectl exec -it
kctx    # trocar context (kubectx)
kns     # trocar namespace (kubens)
k9      # abrir k9s dashboard
```

### Git
```bash
gs      # git status -sb
ga      # git add
gc      # git commit -m
gp      # git push
gpull   # git pull --rebase
gco     # git checkout
gcb     # git checkout -b
glog    # git log --oneline --graph
gundo   # git reset --soft HEAD^
```

### Sistema
```bash
ll      # exa -lah --icons
lt      # exa --tree --level=2 --icons
c       # code . (abre VSCode)
..      # cd ..
...     # cd ../..
z       # zoxide (cd inteligente)
```

## 🎨 Ferramentas CLI Modernas

- **exa** - `ls` melhorado com ícones e cores
- **bat** - `cat` com syntax highlighting
- **fzf** - Fuzzy finder interativo
- **ripgrep** - Busca ultra-rápida (rg)
- **fd** - `find` melhorado
- **zoxide** - `cd` inteligente que aprende seus padrões
- **htop** - Monitor de processos
- **ncdu** - Analisador de uso de disco
- **tldr** - Man pages simplificadas
- **jq** - Processador JSON na linha de comando

## 🔄 Sincronização

### Atualizar dotfiles após mudanças

```bash
cd ~/dotfiles
./sync.sh "Descrição das mudanças"
```

### Ou use o alias (mais prático)

```bash
# Adicione no ~/.zshrc
alias dotsync='cd ~/dotfiles && ./sync.sh'

# Uso
dotsync "Atualizei configs do Python"
```

## 📸 Estrutura do Repositório

```
dotfiles/
├── install.sh              # Script de instalação completo
├── sync.sh                 # Script de sincronização
├── README.md               # Esta documentação
├── .gitignore             # Arquivos a ignorar
│
├── vscode/
│   ├── settings.json      # Configurações do VSCode
│   ├── keybindings.json   # Atalhos personalizados
│   └── extensions.txt     # Lista de extensões
│
├── zsh/
│   ├── .zshrc             # Configuração do Zsh
│   └── .p10k.zsh          # Tema Powerlevel10k
│
├── git/
│   ├── .gitconfig         # Config global do Git
│   └── .gitignore_global  # Gitignore global
│
└── terminal/
    └── windows-terminal.json  # Config do Windows Terminal
```

## 🎯 Configuração por Projeto

### Node.js/TypeScript
```bash
# Criar novo projeto
mkdir meu-projeto && cd meu-projeto

# Inicializar com pnpm
pnpm init

# Ou com Vite + React + TypeScript
pnpm create vite . --template react-ts
pnpm install
pnpm dev
```

### Python
```bash
# Criar novo projeto com Poetry
mkdir meu-projeto && cd meu-projeto
poetry init
poetry add fastapi uvicorn
poetry shell
```

### .NET
```bash
# Criar novo projeto
dotnet new webapi -n MinhaAPI
cd MinhaAPI
dotnet watch run
```

### Docker
```bash
# Iniciar projeto com Docker Compose
# Use templates em: docker-compose-templates.yml
dc up -d
dc logs -f
```

### Kubernetes
```bash
# Deploy no cluster
kubectl apply -f deployment.yaml
kgp
kl pod-name

# Ou com Helm
helm install myapp ./mychart
```

## 🔐 Configurações Pessoais

Após instalar, configure suas credenciais:

```bash
# Git
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"

# GitHub CLI
gh auth login

# NPM (se for publicar pacotes)
npm login

# Poetry (se for publicar no PyPI)
poetry config pypi-token.pypi YOUR_TOKEN
```

## 📚 Recursos Adicionais

### Node.js/TypeScript
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [React Docs](https://react.dev/)
- [Vite Guide](https://vitejs.dev/guide/)

### Python
- [Poetry Docs](https://python-poetry.org/docs/)
- [Python Docs](https://docs.python.org/3/)
- [FastAPI](https://fastapi.tiangolo.com/)

### .NET
- [.NET Docs](https://docs.microsoft.com/dotnet/)
- [C# Guide](https://docs.microsoft.com/dotnet/csharp/)
- [ASP.NET Core](https://docs.microsoft.com/aspnet/core/)

## 🤝 Contribuindo

Sinta-se livre para usar essas configurações! Se tiver sugestões:

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/melhoria`)
3. Commit suas mudanças (`git commit -m 'Add: nova feature'`)
4. Push para a branch (`git push origin feature/melhoria`)
5. Abra um Pull Request

## 📄 Licença

MIT License - sinta-se livre para usar e modificar.

## 🔗 Links Úteis

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [NVM](https://github.com/nvm-sh/nvm)
- [pyenv](https://github.com/pyenv/pyenv)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [VSCode](https://code.visualstudio.com/)

---

⭐ Se este repositório foi útil, considere dar uma estrela!

**Stack:** Node.js/TS/React 🟢 | Python 🐍 | .NET ⚡