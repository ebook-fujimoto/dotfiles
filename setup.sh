#!/bin/sh

set -e
set -u

setup() {
     dotfiles=$HOME/.dotfiles

     has() {
         type "$1" > /dev/null 2>&1
     }

     symlink() {
         [ -e "$2" ] || ln -s "$1" "$2"
     }

     symlinkf() {
         ln -sf "$1" "$2"
     }

     if [ -d "$dotfiles" ]; then
         (cd "$dotfiles" && git pull --rebase)
     else
         git clone https://github.com/ebook-fujimoto/dotfiles "$dotfiles"
     fi

     has yum && sudo yum install -y jq tig

     has git && symlinkf "$dotfiles/.gitconfig" "$HOME/.gitconfig"
     has git && symlinkf "$dotfiles/.git-completion.bash" "$HOME/.git-completion.bash"

     has git && symlinkf "$dotfiles/.bashrc" "$HOME/.bashrc"
     which go && symlinkf "$dotfiles/.bash_profile" "$HOME/.bash_profile"

     source $HOME/.bash_profile

     which go && go get github.com/motemen/ghq
     which go && go get github.com/peco/peco/cmd/peco
     which go && go get github.com/github/hub
}

setup
