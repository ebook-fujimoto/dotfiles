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

     has yum && sudo yum install -y jq tig git go
     has docker && sudo curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

     has git && symlinkf "$dotfiles/.gitconfig" "$HOME/.gitconfig"
     has git && symlinkf "$dotfiles/.git-completion.bash" "$HOME/.git-completion.bash"

     has git && symlinkf "$dotfiles/.bashrc" "$HOME/.bashrc"
     which go && symlinkf "$dotfiles/.bash_profile" "$HOME/.bash_profile"
     which go && go get github.com/motemen/ghq
     export GO111MODULE=on
     which go && go get github.com/peco/peco/cmd/peco
     sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
     sudo yum install -y gh
     ## maybe bye
     which go && go get github.com/github/hub

     sudo curl -sL https://download.opensuse.org/repositories/shells:fish/CentOS_7/{shells:fish.repo} -o /etc/yum.repos.d/#1
     sudo yum install -y fish util-linux-user
     sudo chsh -s `which fish`

     sudo amazon-linux-extras install -y python3.8 java-openjdk11

     source $HOME/.bash_profile

     ## timezone
     ## sudo ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
     sudo timedatectl set-timezone Asia/Tokyo

     sh $dotfiles/setup_ssh.sh
     sh $dotfiles/resize.sh 20
}

setup
