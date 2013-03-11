# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

RED='\e[1;31m'
BLUE='\e[1;34m'
CYAN='\e[1;36m'
NC='\e[0m' # No Color

#SOURCE git-prompt.sh
source /usr/share/git-core/contrib/completion/git-prompt.sh
source /etc/profile.d/rvm.sh

#export KRB5CCNAME=/tmp/qpid123456

#EXPORTS

#export GIT_PS1_SHOWDIRTYSTATE=true
#export GIT_PS1_SHOWUNTRACKEDFILES=true
#PS1='[\u@\h \W]\$ '
PS1='\['$RED'\][\['$NC'\]\u@\h \W$(__git_ps1 " (%s)")\['$RED'\]]\['$NC'\]\['$BLUE'\]\$\['$NC'\] '
#export PS1='[\u@\h \W$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)")]\$ '

#ALIASES

alias llt="ls -lht --color=auto"
alias ll="ls -lh --color=auto"
alias vR="vim -R"
