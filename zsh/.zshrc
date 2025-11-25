# ============= OH MY ZSH =============
export ZSH="$HOME/.oh-my-zsh"

# Tema
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  node
  npm
  yarn
  python
  pip
  pipenv
  poetry
  dotnet
  docker
  docker-compose
  kubectl
  helm
  minikube
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  history-substring-search
  colored-man-pages
  command-not-found
)

source $ZSH/oh-my-zsh.sh

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============= HISTÓRICO =============
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY          # Salva timestamp
setopt SHARE_HISTORY            # Compartilha entre sessões
setopt HIST_IGNORE_DUPS         # Ignora duplicados
setopt HIST_IGNORE_SPACE        # Ignora comandos com espaço no início
setopt HIST_VERIFY              # Verifica antes de executar do histórico
setopt INC_APPEND_HISTORY       # Adiciona imediatamente

# ============= AUTO-COMPLETION =============
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ============= NAVEGAÇÃO =============
setopt AUTO_CD              # cd automático
setopt AUTO_PUSHD          # pushd automático
setopt PUSHD_IGNORE_DUPS   # Não duplica no stack
setopt PUSHD_SILENT        # Não mostra stack

# ============= CORREÇÃO =============
setopt CORRECT             # Corrige comandos
setopt CORRECT_ALL         # Corrige argumentos

# ============= GLOBBING =============
setopt EXTENDED_GLOB       # Usa # ~ ^ para patterns
setopt GLOB_DOTS          # Inclui arquivos ocultos em *

# ============= VARIÁVEIS DE AMBIENTE =============
export EDITOR='nano'
export VISUAL='code'
export PAGER='less'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# ============= NODE.JS / NVM =============
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# ============= PYTHON / PYENV =============
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Poetry
export PATH="$HOME/.local/bin:$PATH"

# pipx
export PATH="$HOME/.local/bin:$PATH"

# ============= .NET =============
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
export DOTNET_ROOT=/usr/share/dotnet

# ============= DOCKER =============
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# ============= CORES PARA LESS =============
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# ============= ALIASES GERAIS =============
alias cls='clear'
alias reload='source ~/.zshrc'
alias zshconfig='code ~/.zshrc'

# Navegação
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Listagem moderna com exa
if command -v exa &> /dev/null; then
  alias ls='exa --icons'
  alias ll='exa -lah --icons --git'
  alias la='exa -a --icons'
  alias lt='exa --tree --level=2 --icons'
  alias ltree='exa --tree --icons'
else
  alias ll='ls -lah'
  alias la='ls -A'
fi

# cat melhorado com bat
if command -v batcat &> /dev/null; then
  alias cat='batcat'
  alias bat='batcat'
fi

# Confirmação
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Sistema
alias ports='netstat -tulanp'
alias meminfo='free -m -l -t'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias myip='curl ifconfig.me'

# VSCode
alias c='code .'
alias code-insiders='code-insiders'

# ============= NODE.JS ALIASES =============

# npm
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nr='npm run'
alias ns='npm start'
alias nd='npm run dev'
alias nb='npm run build'
alias nt='npm test'
alias nci='npm ci'
alias nu='npm update'
alias nls='npm list --depth=0'
alias nout='npm outdated'

# pnpm
alias pi='pnpm install'
alias pa='pnpm add'
alias pad='pnpm add -D'
alias pr='pnpm run'
alias pd='pnpm dev'
alias pb='pnpm build'
alias pt='pnpm test'
alias pu='pnpm update'

# yarn
alias yi='yarn install'
alias ya='yarn add'
alias yad='yarn add -D'
alias yr='yarn run'
alias yd='yarn dev'
alias yb='yarn build'
alias yt='yarn test'
alias yu='yarn upgrade'

# React/Vite
alias cra='npx create-react-app'
alias crv='npm create vite@latest'
alias next-app='npx create-next-app@latest'

# TypeScript
alias tsc='npx tsc'
alias tsx='npx tsx'

# ============= PYTHON ALIASES =============

# Python básico
alias py='python3'
alias py2='python2'
alias ipy='ipython'
alias pyserver='python3 -m http.server'
alias pyjson='python3 -m json.tool'

# Virtual environments
alias venv='python3 -m venv venv'
alias activate='source venv/bin/activate'
alias deactivate='deactivate'

# pip
alias pipi='pip install'
alias pipir='pip install -r requirements.txt'
alias pipf='pip freeze > requirements.txt'
alias pipu='pip install --upgrade pip'
alias pipls='pip list'

# Poetry
alias po='poetry'
alias poi='poetry install'
alias poa='poetry add'
alias poad='poetry add --group dev'
alias por='poetry run'
alias pos='poetry shell'
alias pob='poetry build'
alias pop='poetry publish'
alias pou='poetry update'
alias pols='poetry show'

# Django (se usar)
alias dj='python manage.py'
alias djrun='python manage.py runserver'
alias djmm='python manage.py makemigrations'
alias djm='python manage.py migrate'
alias djsh='python manage.py shell'
alias djsu='python manage.py createsuperuser'

# Flask (se usar)
alias flask-run='flask run'
alias flask-shell='flask shell'

# Jupyter
alias jn='jupyter notebook'
alias jl='jupyter lab'

# ============= .NET ALIASES =============

# dotnet CLI
alias dn='dotnet new'
alias dr='dotnet run'
alias dw='dotnet watch run'
alias db='dotnet build'
alias dc='dotnet clean'
alias dt='dotnet test'
alias dp='dotnet publish'
alias dres='dotnet restore'

# dotnet packages
alias dna='dotnet add package'
alias dnrm='dotnet remove package'
alias dnl='dotnet list package'
alias dnout='dotnet list package --outdated'

# dotnet tools
alias dni='dotnet tool install'
alias dnu='dotnet tool uninstall'
alias dnup='dotnet tool update'

# dotnet user secrets
alias dns='dotnet user-secrets'
alias dnss='dotnet user-secrets set'
alias dnsl='dotnet user-secrets list'

# Entity Framework
alias ef='dotnet ef'
alias efm='dotnet ef migrations add'
alias efu='dotnet ef database update'
alias efd='dotnet ef database drop'

# Criar projetos comuns
alias dn-console='dotnet new console -n'
alias dn-web='dotnet new web -n'
alias dn-api='dotnet new webapi -n'
alias dn-mvc='dotnet new mvc -n'
alias dn-react='dotnet new react -n'
alias dn-blazor='dotnet new blazorserver -n'
alias dn-lib='dotnet new classlib -n'
alias dn-test='dotnet new xunit -n'

# ============= GIT ALIASES =============

alias g='git'
alias gs='git status -sb'
alias gst='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpu='git push -u origin HEAD'
alias gpull='git pull --rebase'
alias gf='git fetch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gm='git merge'
alias gr='git rebase'
alias gri='git rebase -i'
alias glog='git log --oneline --decorate --graph --all'
alias glg='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gundo='git reset --soft HEAD^'
alias greset='git reset --hard'
alias gstash='git stash'
alias gstashp='git stash pop'
alias gclean='git clean -fd'

# ============= DOCKER ALIASES =============

alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dstop='docker stop'
alias dstart='docker start'
alias drestart='docker restart'
alias drm='docker rm'
alias drmi='docker rmi'
alias dprune='docker system prune -af'
alias dvprune='docker volume prune -f'
alias diprune='docker image prune -af'

# Docker build/run
alias db='docker build -t'
alias drun='docker run --rm -it'
alias drunp='docker run --rm -it -p'
alias drund='docker run -d'

# Docker inspect
alias dins='docker inspect'
alias dstats='docker stats'
alias dtop='docker top'

# Docker Compose
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs -f'
alias dcb='docker-compose build'
alias dce='docker-compose exec'
alias dcps='docker-compose ps'
alias dcpull='docker-compose pull'

# Docker network
alias dnet='docker network ls'
alias dnetins='docker network inspect'

# Docker volume
alias dvol='docker volume ls'
alias dvolins='docker volume inspect'

# ============= KUBERNETES ALIASES =============

alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kga='kubectl get all'
alias kgns='kubectl get namespaces'

# Describe
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'
alias kdn='kubectl describe node'

# Logs
alias kl='kubectl logs'
alias klf='kubectl logs -f'

# Execute
alias kex='kubectl exec -it'
alias kbash='kubectl exec -it -- bash'
alias ksh='kubectl exec -it -- sh'

# Apply/Delete
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kdel='kubectl delete'

# Port forward
alias kpf='kubectl port-forward'

# Context e Namespace
alias kctx='kubectx'
alias kns='kubens'
alias kgctx='kubectl config get-contexts'
alias kusecontext='kubectl config use-context'
alias kcurrent='kubectl config current-context'

# Edit
alias ked='kubectl edit'

# Scale
alias kscale='kubectl scale'

# Rollout
alias krollout='kubectl rollout'
alias krollback='kubectl rollout undo'

# Top (recursos)
alias ktop='kubectl top'
alias ktopp='kubectl top pods'
alias ktopn='kubectl top nodes'

# ============= HELM ALIASES =============

alias h='helm'
alias hi='helm install'
alias hup='helm upgrade'
alias huni='helm uninstall'
alias hls='helm list'
alias hlsa='helm list --all-namespaces'
alias hrepo='helm repo'
alias hrepoup='helm repo update'
alias hsearch='helm search'
alias hshow='helm show'

# ============= MINIKUBE ALIASES =============

alias mk='minikube'
alias mkstart='minikube start'
alias mkstop='minikube stop'
alias mkdel='minikube delete'
alias mkstatus='minikube status'
alias mkdash='minikube dashboard'
alias mkip='minikube ip'
alias mkssh='minikube ssh'
alias mkservice='minikube service'

# ============= K9S =============

alias k9='k9s'

# ============= FUNÇÕES ÚTEIS =============

# Criar diretório e entrar nele
mkcd() { mkdir -p "$1" && cd "$1"; }

# Extrair arquivos compactados
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Buscar em arquivos
fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages "$1" | fzf --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

# Criar projeto Node.js rápido
init-node() {
    mkdir -p "$1" && cd "$1"
    pnpm init
    pnpm add -D typescript @types/node tsx
    mkdir src
    echo 'console.log("Hello World");' > src/index.ts
    echo "Projeto Node.js criado em $1"
}

# Criar projeto Python rápido
init-python() {
    mkdir -p "$1" && cd "$1"
    poetry init -n
    poetry add --group dev black ruff mypy
    mkdir src tests
    echo 'def main():
    print("Hello World")

if __name__ == "__main__":
    main()' > src/main.py
    echo "Projeto Python criado em $1"
}

# Criar projeto .NET rápido
init-dotnet() {
    dotnet new webapi -n "$1"
    cd "$1"
    echo "Projeto .NET criado em $1"
}

# Kill processo por porta
killport() {
    if [ -z "$1" ]; then
        echo "Usage: killport <port>"
        return 1
    fi
    lsof -ti:$1 | xargs kill -9
}

# ============= ZOXIDE (CD INTELIGENTE) =============
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# ============= KUBERNETES / HELM =============
export KUBECONFIG=~/.kube/config
export KUBE_EDITOR='nano'

# Autocompletion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
fi

if command -v helm &> /dev/null; then
    source <(helm completion zsh)
fi

if command -v minikube &> /dev/null; then
    source <(minikube completion zsh)
fi
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

# Ctrl+R melhorado com fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# ============= KEYBINDINGS =============
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# ============= POWERLEVEL10K =============
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============= DOTFILES SYNC =============
alias dotfiles='cd ~/dotfiles'
alias dotsync='cd ~/dotfiles && ./sync.sh'

# ============= MENSAGEM DE BOAS-VINDAS =============
echo "🚀 Stack: Node.js/TS/React 🟢 | Python 🐍 | .NET ⚡"