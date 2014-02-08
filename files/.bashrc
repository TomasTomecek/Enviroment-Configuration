# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

BOLD="\[\033[1m\]"
RED="\[\033[1;31m\]"
GREEN="\[\e[32;1m\]"
BLUE="\[\e[34;1m\]"
OFF="\[\033[m\]"
CYAN="\[\e[1;36m\]"

#SOURCE git-prompt.sh
source /usr/share/git-core/contrib/completion/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM="verbose"
GIT_PS1_SHOWCOLORHINTS=true

export HISTSIZE=200000
export HISTFILESIZE=200000

function exitstatus {
    EXITSTATUS="$?"
    JOBS_COUNT=$(jobs | wc -l)
    
    PS1=""

    if [ "$UID" -eq 0 ] ; then
        PS1=${PS1}"${RED}\u${OFF}@"
    fi
    PS1=${PS1}"${GREEN}\h${OFF}"
    
    PS1=${PS1}' \w$(__git_ps1 " (%s)")'
    
    if [ "${EXITSTATUS}" -ne 0 ] ; then
        PS1=${PS1}"${RED} ${EXITSTATUS}${OFF}"
    fi
    if [ "${JOBS_COUNT}" -ne 0 ] ; then
        PS1=${PS1}"${CYAN} ${JOBS_COUNT}${OFF}"
    fi
    PS1=${PS1}" \$ "
}
PROMPT_COMMAND=exitstatus

#powerline_path="/usr/lib/python2.7/site-packages/powerline"
#source ${powerline_path}/bindings/bash/powerline.sh

#ALIASES

alias llt="ls -lht --color=auto"
alias ll="ls -lh --color=auto"
alias lla="ls -lha --color=auto"
alias vR="vim -R"
alias gt="gnome-terminal --maximize"
alias tree="tree -C"
alias less="less -r"
alias vs="vim ./*.spec"
alias gs="git status"
alias gd="git diff"
alias rpmbc="rpmbuild -bs ./*.spec --define \"_sourcedir .\" --define \"_specdir .\" --define \"_srcrpmdir .\" --define \"_rpmdir .\""
