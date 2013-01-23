# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#red='\e[0;31m'
RED='\e[1;31m'
#blue='\e[0;34m'
BLUE='\e[1;34m'
#cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m' # No Color

#. /etc/bash_completion.d/rhpkg.bash
#export KRB5CCNAME=/tmp/qpid123456

#EXPORTS

export KOBO_PKG="/usr/lib/python2.7/site-packages/kobo/"
#export GIT_PS1_SHOWDIRTYSTATE=true
#export GIT_PS1_SHOWUNTRACKEDFILES=true
#PS1='[\u@\h \W]\$ '
PS1='\['$RED'\][\['$NC'\]\u@\h \W$(__git_ps1 " (%s)")\['$RED'\]]\$\['$NC'\] '
#export PS1='[\u@\h \W$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)")]\$ '


