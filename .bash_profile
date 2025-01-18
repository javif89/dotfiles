# Auto start zellij
if [[ -z "$ZELLIJ" ]]; then
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
    else
        zellij
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
fi

# Aliases
alias bisnow="~/bisnow"
alias vim="nvim"
alias nv="nvim"

# Color LS
colorflag="-G"
alias ls="command ls ${colorflag}"
alias l="ls -lF ${colorflag}" # all files, in long format
alias la="ls -laF ${colorflag}" # all files inc dotfiles, in long format
alias lsd='ls -lF ${colorflag} | grep "^d"' # only directories

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Install and remove packages
alias install="sudo apt install -y"

# Config files
alias kittyc="nvim ~/.config/kitty"
alias helixc="nvim ~/.config/helix"
alias starc="nvim ~/.config/starship.toml"

function nvimc() {
	cd "~/.config/nvim"
	nvim .
}

# Git
# You must install Git first
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message
alias grm='git rm $(git ls-files --deleted)'
alias gb="git checkout -b"

function commit() {
	git add .
	git commit -m "$1"
}

function push() {
	branch=$(parse_git_branch)
	git push -u origin "$branch"
}

# # Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] 
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Docker aliases
alias dc="docker-compose"
alias bx="docker buildx"
alias de="docker exec -it"
alias dub="docker compose up -d --build"
alias dup="docker-compose up"
alias dwn="docker-compose down"
alias da="docker_artisan"

# Laravel & php
alias a="php artisan"

# Convenience
alias ep="nvim ~/.bash_profile"
alias rp="source ~/.bash_profile && clear"
alias edithosts="nvim /etc/hosts"
alias cls="clear"
alias editpath="nvim /etc/paths"
alias home="cd ~"
alias projects="cd ~/projects"
alias co="code ."
alias locl="cd ~/Sites/local"
alias cdpl="cd deploy/local"

# Laravel sail
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias sup="sail up -d"
alias sd="sail down"
alias sa="sail artisan"
alias sc="sail composer"
alias st="sail test"
alias stf="sail composer tf"
alias rebuild="sail down && sail build --no-cache && sail up -d"

# Temp
alias smp="sa migrate:rollback && sa migrate && clear && sa db:seed --class=SimpleMapSeeder"
alias stackartisan="docker exec -it stack-ems php /usr/src/myapp/artisan"

# Jigsaw
alias jig="vendor/bin/jigsaw"

# Golang
alias gr="go run ."
alias gmt="go mod tidy"
alias ccl="cobra-cli"

# # Functions
# Running tests in containers
function test() {
	clear
	de "$1" ./vendor/bin/phpunit --testdox
}

function testf() {
	clear
  da "$1" config:clear
	de "$1" ./vendor/bin/phpunit --testdox --filter="$2"
}

function docker_artisan() {
	de "$1" php artisan "$2" "${@:3}"
}


function commit() {
	ga
	gc "$1"
}

function site() {
	cd ~/Sites/"$1"
}

function sdpl() {
	cd ~/Sites/"$1"/deploy/local
}

# Temp
function tcf() {
    clear
    de contacts ./vendor/bin/phpunit --testdox --filter="$1"
}

# Open something in the projects folder
function o() {
	cd "$HOME/projects/$1"
}

function helixdocs() {
	open "https://docs.helix-editor.com/usage.html"
}

eval "$(starship init bash)"
. "$HOME/.cargo/env"
