
[[ -o interactive && -t 0 ]] || return

printf "\n"
printf "KornShell\n"
ksh --version
printf "ENV: ${ENV}\n"
printf "\n"

set -o nolog
set -o emacs
set -o ignoreeof

export PAGER=less
export CDPATH=.:$HOME:$HOME/projects
export GREP_OPTIONS='--color=auto'

alias ll='ls -lFhb'
alias la='ls -lAFb'
alias pu='ps -fu $USER
