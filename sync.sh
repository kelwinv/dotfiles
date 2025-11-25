#!/bin/bash

# Script para sincronizar configurações atuais com o repositório
# Uso: ./sync.sh [mensagem do commit]

set -e

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Diretório dos dotfiles
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo -e "${BLUE}🔄 Sincronizando dotfiles...${NC}\n"

# ============= COPIAR CONFIGURAÇÕES =============

# Zsh
echo -e "${YELLOW}Copiando .zshrc...${NC}"
cp ~/.zshrc zsh/.zshrc
if [ -f ~/.p10k.zsh ]; then
    cp ~/.p10k.zsh zsh/.p10k.zsh
fi

# Git
echo -e "${YELLOW}Copiando .gitconfig...${NC}"
if [ -f ~/.gitconfig ]; then
    cp ~/.gitconfig git/.gitconfig
fi

if [ -f ~/.gitignore_global ]; then
    cp ~/.gitignore_global git/.gitignore_global
fi

# VSCode (detectar usuário do Windows)
WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')

if [ -n "$WIN_USER" ]; then
    VSCODE_DIR="/mnt/c/Users/$WIN_USER/AppData/Roaming/Code/User"
    
    if [ -d "$VSCODE_DIR" ]; then
        echo -e "${YELLOW}Copiando configurações do VSCode...${NC}"
        cp "$VSCODE_DIR/settings.json" vscode/settings.json
        
        if [ -f "$VSCODE_DIR/keybindings.json" ]; then
            cp "$VSCODE_DIR/keybindings.json" vscode/keybindings.json
        fi
        
        # Copiar lista de extensões
        code --list-extensions > vscode/extensions.txt
    fi
    
    # Windows Terminal
    TERMINAL_DIR="/mnt/c/Users/$WIN_USER/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
    if [ -f "$TERMINAL_DIR/settings.json" ]; then
        echo -e "${YELLOW}Copiando configurações do Windows Terminal...${NC}"
        cp "$TERMINAL_DIR/settings.json" terminal/windows-terminal.json
    fi
fi

# ============= VERIFICAR MUDANÇAS =============

if [ -z "$(git status --porcelain)" ]; then
    echo -e "\n${GREEN}✓ Nenhuma mudança detectada${NC}"
    exit 0
fi

# ============= MOSTRAR MUDANÇAS =============

echo -e "\n${BLUE}Mudanças detectadas:${NC}"
git status --short

# ============= COMMIT E PUSH =============

# Mensagem do commit
if [ -n "$1" ]; then
    COMMIT_MSG="$1"
else
    COMMIT_MSG="Update configurations - $(date '+%Y-%m-%d %H:%M')"
fi

echo -e "\n${YELLOW}Commit message: ${COMMIT_MSG}${NC}"

# Adicionar todas as mudanças
git add .

# Commit
git commit -m "$COMMIT_MSG"

# Push
echo -e "\n${YELLOW}Fazendo push para o GitHub...${NC}"
git push

echo -e "\n${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ Sincronização concluída!${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}\n"