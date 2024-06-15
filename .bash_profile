unset PROMPT_COMMAND

eval "$(/opt/homebrew/bin/brew shellenv)"


### Prompt Colors
# Modified version of @gf3’s Sexy Bash Prompt
# (https://github.com/gf3/dotfiles)
# if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
# 	export TERM=gnome-256color
# elif infocmp xterm-256color >/dev/null 2>&1; then
# 	export TERM=xterm-256color
# fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
		MAGENTA=$(tput setaf 9)
		ORANGE=$(tput setaf 172)
		GREEN=$(tput setaf 190)
		PURPLE=$(tput setaf 141)
	else
		MAGENTA=$(tput setaf 5)
		ORANGE=$(tput setaf 4)
		GREEN=$(tput setaf 2)
		PURPLE=$(tput setaf 1)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"
	BOLD=""
	RESET="\033[0m"
fi

export MAGENTA
export ORANGE
export GREEN
export PURPLE
export BOLD
export RESET

# # Change this symbol to something sweet.
# # (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="> "

# export PS1="\[${PURPLE}\]\u \[$RESET\]in \[$GREEN\]\w\[$RESET\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$RESET\]\n$symbol\[$RESET\]"
# # export PS2="\[$ORANGE\]→ \[$RESET\]"


# ### Misc

# # Only show the current directory's name in the tab
# # export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$HOME/go/bin"

# Aliases
alias bisnow="~/bisnow"
alias vim="nvim"
alias assume=". assume"

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

# Config files
alias kittyc="hx ~/.config/kitty"
alias helixc="hx ~/.config/helix"
alias starc="hx ~/.config/starship.toml"

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
alias stc="sail composer test-with-coverage"

# Convenience
alias ep="hx ~/.bash_profile"
alias rp="source ~/.bash_profile && clear"
alias edithosts="hx /etc/hosts"
alias cls="clear"
alias editpath="hx /etc/paths"
alias sites="cd ~/Sites"
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
