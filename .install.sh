#!/bin/bash

# Script de instalação completo dos dotfiles
# Stack: Node.js/TypeScript/React + Python + .NET
# Uso: ./install.sh

set -e

echo "🚀 Instalando dotfiles completo..."

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para criar backup
backup_file() {
    if [ -f "$1" ]; then
        echo -e "${YELLOW}Criando backup de $1${NC}"
        cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
    fi
}

# Função para criar symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -f "$target" ] || [ -L "$target" ]; then
        backup_file "$target"
        rm -f "$target"
    fi
    
    ln -sf "$source" "$target"
    echo -e "${GREEN}✓ Linked: $target${NC}"
}

# Diretório base dos dotfiles
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ============= DEPENDÊNCIAS BÁSICAS =============
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📦 Instalando dependências básicas...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

sudo apt update
sudo apt install -y \
    build-essential \
    curl \
    wget \
    git \
    unzip \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# ============= ZSH =============
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🐚 Configurando Zsh...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

sudo apt install -y zsh

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Instalar plugins
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo "Instalando zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "Instalando zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions" ]; then
    echo "Instalando zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
fi

# Instalar Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Instalando Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

if [ -f "$DOTFILES_DIR/zsh/.p10k.zsh" ]; then
    create_symlink "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
fi

# ============= NODE.JS / NVM =============
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📗 Instalando Node.js (NVM)...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ ! -d "$HOME/.nvm" ]; then
    echo "Instalando NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    echo "Instalando Node.js LTS..."
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
else
    echo -e "${GREEN}✓ NVM já instalado${NC}"
fi

# Instalar gerenciadores de pacotes globais
if command -v node &> /dev/null; then
    echo "Instalando pnpm, yarn e ferramentas globais..."
    npm install -g pnpm yarn typescript tsx @types/node
    
    # Create React App e Vite
    npm install -g create-react-app
    
    # ESLint e Prettier
    npm install -g eslint prettier
    
    echo -e "${GREEN}✓ Node.js e ferramentas instaladas${NC}"
fi

# ============= PYTHON / PYENV =============
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🐍 Instalando Python (pyenv)...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Dependências do pyenv
sudo apt install -y \
    make \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

if [ ! -d "$HOME/.pyenv" ]; then
    echo "Instalando pyenv..."
    curl https://pyenv.run | bash
    
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    
    echo "Instalando Python 3.12..."
    pyenv install 3.12
    pyenv global 3.12
else
    echo -e "${GREEN}✓ pyenv já instalado${NC}"
fi

# Instalar Poetry (gerenciador de dependências Python)
if ! command -v poetry &> /dev/null; then
    echo "Instalando Poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
else
    echo -e "${GREEN}✓ Poetry já instalado${NC}"
fi

# Instalar pipx e ferramentas Python
if ! command -v pipx &> /dev/null; then
    echo "Instalando pipx..."
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
fi

# Ferramentas Python úteis
if command -v pipx &> /dev/null; then
    echo "Instalando ferramentas Python..."
    pipx install black
    pipx install ruff
    pipx install mypy
    pipx install ipython
    pipx install httpie
fi

# ============= .NET SDK =============
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}⚡ Instalando .NET SDK...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if ! command -v dotnet &> /dev/null; then
    echo "Instalando .NET 8 SDK..."
    
    # Adicionar repositório da Microsoft
    wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    
    # Instalar .NET SDK
    sudo apt update
    sudo apt install -y dotnet-sdk-8.0
    
    echo -e "${GREEN}✓ .NET 8 SDK instalado${NC}"
else
    echo -e "${GREEN}✓ .NET já instalado - Versão: $(dotnet --version)${NC}"
fi

# ============= GIT =============
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📝 Configurando Git...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

create_symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

if [ -f "$DOTFILES_DIR/git/.gitignore_global" ]; then
    create_symlink "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
fi

# Instalar GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "Instalando GitHub CLI..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install -y gh
else
    echo -e "${GREEN}✓ GitHub CLI já instalado${NC}"
fi

# ============= DOCKER =============
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🐳 Instalando Docker...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if ! command -v docker &> /dev/null; then
    echo "Instalando Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
    
    echo -e "${GREEN}✓ Docker instalado${NC}"
    echo -e "${YELLOW}⚠ Execute 'newgrp docker' ou faça logout/login para usar Docker sem sudo${NC}"
else
    echo -e "${GREEN}✓ Docker já instalado - Versão: $(docker --version | cut -d' ' -f3 | cut -d',' -f1)${NC}"
fi

# Instalar Docker Compose (standalone)
if ! command -v docker-compose &> /dev/null; then
    echo "Instalando Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo -e "${GREEN}✓ Docker Compose instalado${NC}"
else
    echo -e "${GREEN}✓ Docker Compose já instalado - Versão: $(docker-compose --version | cut -d' ' -f4 | cut -d',' -f1)${NC}"
fi

# ============= KUBERNETES =============
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}☸️  Instalando Kubernetes Tools...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# kubectl
if ! command -v kubectl &> /dev/null; then
    echo "Instalando kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
    echo -e "${GREEN}✓ kubectl instalado${NC}"
else
    echo -e "${GREEN}✓ kubectl já instalado - Versão: $(kubectl version --client --short 2>/dev/null | cut -d' ' -f3)${NC}"
fi

# kubectx e kubens (troca rápida de contexto e namespace)
if [ ! -d "$HOME/.kubectx" ]; then
    echo "Instalando kubectx e kubens..."
    git clone https://github.com/ahmetb/kubectx ~/.kubectx
    sudo ln -sf ~/.kubectx/kubectx /usr/local/bin/kubectx
    sudo ln -sf ~/.kubectx/kubens /usr/local/bin/kubens
    echo -e "${GREEN}✓ kubectx e kubens instalados${NC}"
else
    echo -e "${GREEN}✓ kubectx e kubens já instalados${NC}"
fi

# k9s (dashboard interativo para Kubernetes)
if ! command -v k9s &> /dev/null; then
    echo "Instalando k9s..."
    K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
    curl -sL "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz" | sudo tar xz -C /usr/local/bin k9s
    echo -e "${GREEN}✓ k9s instalado${NC}"
else
    echo -e "${GREEN}✓ k9s já instalado${NC}"
fi

# Helm (package manager para Kubernetes)
if ! command -v helm &> /dev/null; then
    echo "Instalando Helm..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    echo -e "${GREEN}✓ Helm instalado${NC}"
else
    echo -e "${GREEN}✓ Helm já instalado - Versão: $(helm version --short | cut -d'+' -f1)${NC}"
fi

# Minikube (Kubernetes local)
if ! command -v minikube &> /dev/null; then
    echo "Instalando Minikube..."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
    echo -e "${GREEN}✓ Minikube instalado${NC}"
else
    echo -e "${GREEN}✓ Minikube já instalado - Versão: $(minikube version --short)${NC}"
fi

# ============= VSCODE =============
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}💻 Configurando VSCode...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Detectar usuário do Windows
WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')

if [ -n "$WIN_USER" ]; then
    VSCODE_DIR="/mnt/c/Users/$WIN_USER/AppData/Roaming/Code/User"
    
    if [ -d "$VSCODE_DIR" ]; then
        backup_file "$VSCODE_DIR/settings.json"
        cp "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_DIR/settings.json"
        echo -e "${GREEN}✓ VSCode settings.json copiado${NC}"
        
        if [ -f "$DOTFILES_DIR/vscode/keybindings.json" ]; then
            backup_file "$VSCODE_DIR/keybindings.json"
            cp "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"
            echo -e "${GREEN}✓ VSCode keybindings.json copiado${NC}"
        fi
        
        # Instalar extensões
        if [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
            echo "Instalando extensões do VSCode..."
            while read extension; do
                code --install-extension "$extension" --force
            done < "$DOTFILES_DIR/vscode/extensions.txt"
        fi
    else
        echo -e "${YELLOW}⚠ Diretório do VSCode não encontrado${NC}"
    fi
fi

# ============= FERRAMENTAS CLI =============
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🛠️  Instalando ferramentas CLI...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Ferramentas modernas
TOOLS=("exa" "bat" "fzf" "ripgrep" "fd-find" "htop" "ncdu" "tldr" "jq")

for tool in "${TOOLS[@]}"; do
    if ! command -v "$tool" &> /dev/null && ! dpkg -l | grep -q "^ii  $tool "; then
        echo "Instalando $tool..."
        sudo apt install -y "$tool"
    else
        echo -e "${GREEN}✓ $tool já instalado${NC}"
    fi
done

# Zoxide (cd inteligente)
if ! command -v zoxide &> /dev/null; then
    echo "Instalando zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
else
    echo -e "${GREEN}✓ zoxide já instalado${NC}"
fi

# ============= FINALIZAR =============
echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Instalação concluída!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo -e "\n${BLUE}📋 Versões instaladas:${NC}"
[ -f "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh" && echo "Node.js: $(node --version)"
[ -d "$HOME/.pyenv" ] && export PATH="$HOME/.pyenv/bin:$PATH" && echo "Python: $(pyenv version | cut -d' ' -f1)"
command -v dotnet &> /dev/null && echo ".NET: $(dotnet --version)"
command -v docker &> /dev/null && echo "Docker: $(docker --version | cut -d' ' -f3 | cut -d',' -f1)"
command -v kubectl &> /dev/null && echo "kubectl: $(kubectl version --client --short 2>/dev/null | cut -d' ' -f3)"
command -v helm &> /dev/null && echo "Helm: $(helm version --short | cut -d'+' -f1)"

echo -e "\n${YELLOW}📝 Próximos passos:${NC}"
echo "1. Reinicie o terminal ou execute: source ~/.zshrc"
echo "2. Configure o Powerlevel10k: p10k configure"
echo "3. Autentique no GitHub: gh auth login"
echo "4. Para usar Docker sem sudo: newgrp docker (ou faça logout/login)"
echo "5. Reinicie o VSCode para aplicar as configurações"
echo ""
echo -e "${YELLOW}🔧 Configurações de usuário Git:${NC}"
echo "git config --global user.name \"Seu Nome\""
echo "git config --global user.email \"seu@email.com\""
echo ""
echo -e "${YELLOW}💾 Backups criados em:${NC}"
echo "~/.zshrc.backup.*"
echo "~/.gitconfig.backup.*"
echo ""