#
# ~/.bashrc
#

# Prompt
workingdir='\[$(tput setaf 2)\]\w'
colorreset='\[$(tput sgr0)\]'
prompticon='\[$(tput setaf 13)\]>'
# gitbranch="$(git branch --show-current)"
PS1=" $workingdir \n $prompticon $colorreset "

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls="ls -a --color=auto"
alias grep="grep --color=auto"

alias ep="helix ~/.bashrc"
alias rp="source ~/.bash_profile"
alias cls="clear"
alias initd="~/init"
alias paci="sudo pacman -S"
alias pacr="sudo pacman -Rsc"
alias hyprc="helix ~/.config/hypr"
alias waybarc="helix ~/.config/waybar"
alias kittyc="helix ~/.config/kitty"
alias hx="helix"
alias initd="Hyprland"
alias dotfiles="cd ~/dotfiles"

# Git shortcuts
alias gs="git status"
alias gc="git commit -m"
alias ga="git add ."

# Shortcuts for starting certain apps
alias dockerdesktop="systemctl --user start docker-desktop"

# Directory traversal
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias home="cd $HOME"

# Go
alias gr="go run ."
alias gmf="go fmt"

alias turnoff="sudo shutdown now"

bkup() {
  mv $1 "$1.bak"
}

bkupc() {
  cp $1 "$1.bak"
}

stowdotfile() {
  cp "$1" "$HOME/dotfiles"
  bkup "$1"
  cd "$HOME/dotfiles"
  stow .
}

chbg() {
  filename=$(basename -- "$1")
  extension="${filename##*.}"
  name="${filename%.*}"

  file="$1"
  
  if [ $extension != "png" ] 
  then
    echo "Converting to PNG from $extension"
    magick $1 "$name.png"
    file="$name.png"

    rm "$1"
  fi

  bkup "$HOME/desktopbg.png"
  echo "Copying $file to ~/desktopbg.png"
  cp "$file" "$HOME/desktopbg.png"
  echo "Done"

  echo "Restarting swaybg"

  swaybg --mode fill --image "$HOME/desktopbg.png" > /dev/null 2>&1 & 
}

rlbg() {
    swaybg --mode fill --image "$HOME/desktopbg.png" > /dev/null 2>&1 & 
}

rlwaybar() {
  killall waybar 
  waybar > /dev/null 2>&1 &
}

cpconf() {
  path="$HOME/.config/$1"
  if [ -d "$path" ]; then
    target="$HOME/dotfiles/.config/"
    echo "Copying $path > $target"
    mkdir -p "$target"
    cp -a "$path" "$target"
  else
    cp "$path" "$HOME/dotfiles/.config/"
  fi
}

pushdotfiles() {
  cd "$HOME/dotfiles"
  git add .
  timestamp="$(date +"%Y-%m-%d %T")"
  git commit -m "$timestamp: Commit by bash script"
  git push -u origin main
}

helixdocs() {
  chromium "https://docs.helix-editor.com/"
}
. "$HOME/.cargo/env"

mkcd() {
  mkdir "$1" && cd "$1"
}
