set -o notify
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s extglob
shopt -s histappend histreedit histverify
shopt -s no_empty_cmd_completion

complete -A hostname   telnet ping ssh
complete -A export     printenv env
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su
complete -A helptopic  help
complete -A shopt      shopt
complete -A stopped -P "%" bg
complete -A job -P "%" fg jobs disown
complete -A directory  mkdir rmdir

stty -ixon -ixoff

export EDITOR="/usr/bin/vim"
export PAGER="/usr/bin/less"
export HISTTIMEFORMAT="%F %T "

alias grep="grep --color=auto"
alias less="less -IMR"
alias ls="ls -Fla --color"
alias p="ps faux"
alias s="screen -U -r -d"
alias pwgen="echo \$(tr -dc A-Za-z0-9 < /dev/urandom | head -c\$(tput cols))"

c () { echo "scale=6;0.0+""$@" | bc -l; }
..() { for (( i = 0; i < ${1-1}; i++ )); do cd ..; done; }
cd() { builtin cd "$@" && \ls -Fa --color; }

PS1="\[\e]0;\h (pts/\l #\#) \w\a\]\[\e[1;37m\]\t\[\e[01;30m\](!\! j\j x\`[[ \$? == 0 ]] && echo \[\e[33m\]0\[\e[0m\] || echo \[\e[31m\]\$?\[\e[0m\]\`)\[\e[1;37m\]\u@\h:\w>\[\e[00m\] "

