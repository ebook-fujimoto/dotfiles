#!/bin/sh

set -e
set -u

setup() {
     which go && go get github.com/motemen/ghq
     which go && go get github.com/peco/peco/cmd/peco
     which go && go get github.com/github/hub
     ghq
}

setup