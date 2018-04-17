#!/bin/bash

source $SOE_INSTALL/bin/common/prop.sh

GIT_USER=$(prop 'git.user')
GIT_EMAIL=$(prop 'git.email')
GIT_EDITOR=$(prop 'git.editor')

IGNORE_FILE=$SOE_INSTALL/files/git/.gitignore_global

configure-git() {
    git config --global user.name ${GIT_USER:-$USER}
    git config --global user.email ${GIT_EMAIL:-$USER@$HOST}
    git config --global core.editor ${GIT_EDITOR:-vim}
    git config --global core.autocrlf input
    git config --global help.autocorrect 17
}

configure-git-ignore() {
    cp $IGNORE_FILE $HOME
    git config --global core.excludesfile $HOME/.gitignore_global
}

configure-git
configure-git-ignore
