
# Check for an interactive session
[ -z "$PS1" ] && return
alias pacman='sudo pacman-color'
alias bauerbill='sudo bauerbill'
alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
#PS1='8=======D~~~ ' #LOOOOOL
PS1='[ \[\e[1;34m\]\W\[\e[m\] ] \[\e[1;32m\]\$ \[\e[m\]'

calc(){ awk "BEGIN{ print $* }" ;}
complete -cf sudo
