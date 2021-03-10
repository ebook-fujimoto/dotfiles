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

     sudo curl -sL https://download.opensuse.org/repositories/shells:fish/CentOS_7/{shells:fish.repo} -o /etc/yum.repos.d/#1
     sudo yum install -y fish util-linux-user
     sudo chsh -s `which fish`

     sudo amazon-linux-extras install -y python3.8

     source $HOME/.bash_profile
}

setup
