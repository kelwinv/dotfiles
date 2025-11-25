#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}🔧 Iniciando instalação completa...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# ------------------------------------------------------------
# Atualização
# ------------------------------------------------------------
echo -e "${GREEN}Atualizando pacotes...${NC}"
sudo apt update -y
sudo apt upgrade -y

# ------------------------------------------------------------
# Ferramentas essenciais
# ------------------------------------------------------------
echo -e "${GREEN}Instalando ferramentas essenciais...${NC}"
sudo apt install -y \
  git curl wget unzip build-essential \
  software-properties-common ca-certificates \
  pkg-config libssl-dev

# ------------------------------------------------------------
# Node.js via NVM
# ------------------------------------------------------------
if ! command -v node >/dev/null; then
  echo -e "${GREEN}Instalando Node.js via NVM...${NC}"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  source "$NVM_DIR/nvm.sh"
  nvm install 20
  nvm alias default 20
else
  echo -e "${YELLOW}Node.js já instalado. Pulando...${NC}"
fi

# ------------------------------------------------------------
# Python: pyenv + Poetry + pipx
# ------------------------------------------------------------
if ! command -v pyenv >/dev/null; then
  echo -e "${GREEN}Instalando pyenv...${NC}"
  curl https://pyenv.run | bash

  echo -e 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo -e 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo -e 'eval "$(pyenv init -)"' >> ~/.bashrc

  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

if ! command -v poetry >/dev/null; then
  echo -e "${GREEN}Instalando Poetry...${NC}"
  curl -sSL https://install.python-poetry.org | python3 -
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

if ! command -v pipx >/dev/null; then
  echo -e "${GREEN}Instalando pipx...${NC}"
  sudo apt install -y pipx
  pipx ensurepath
fi

# ------------------------------------------------------------
# .NET SDK 8 + EF Tools
# ------------------------------------------------------------
if ! command -v dotnet >/dev/null; then
  echo -e "${GREEN}Instalando .NET SDK 8.0...${NC}"

  wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  sudo apt update -y

  sudo apt install -y dotnet-sdk-8.0
  rm -f packages-microsoft-prod.deb

  echo -e "${GREEN}Instalando ferramentas do .NET...${NC}"
  dotnet tool install --global dotnet-ef
  dotnet new install Microsoft.Azure.Functions.Worker.Templates

  echo 'export PATH="$PATH:$HOME/.dotnet/tools"' >> ~/.bashrc
else
  echo -e "${YELLOW}.NET já instalado. Pulando...${NC}"
fi

# ------------------------------------------------------------
# Docker + Docker Compose
# ------------------------------------------------------------
if ! command -v docker >/dev/null; then
  echo -e "${GREEN}Instalando Docker...${NC}"
  curl -fsSL https://get.docker.com | sudo sh
  sudo usermod -aG docker $USER
else
  echo -e "${YELLOW}Docker já instalado. Pulando...${NC}"
fi

# ------------------------------------------------------------
# Kubernetes (kubectl + minikube)
# ------------------------------------------------------------
if ! command -v kubectl >/dev/null; then
  echo -e "${GREEN}Instalando kubectl...${NC}"
  sudo curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    -o /usr/local/bin/kubectl
  sudo chmod +x /usr/local/bin/kubectl
fi

if ! command -v minikube >/dev/null; then
  echo -e "${GREEN}Instalando Minikube...${NC}"
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  rm minikube-linux-amd64
fi

# ------------------------------------------------------------
# Zsh + Oh My Zsh
# ------------------------------------------------------------
if ! command -v zsh >/dev/null; then
  echo -e "${GREEN}Instalando Zsh e Oh My Zsh...${NC}"
  sudo apt install -y zsh
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo -e "${YELLOW}Zsh já instalado. Pulando...${NC}"
fi

# ------------------------------------------------------------
# Finalização
# ------------------------------------------------------------
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Instalação concluída com sucesso!${NC}"
echo -e "${YELLOW}Reinicie o terminal para aplicar todas as variáveis.${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
