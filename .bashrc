# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export WORKON_HOME=$HOME/.virtualenvs

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/python3/bin/virtualenv

source /usr/local/python3/bin/virtualenvwrapper.sh

export LANG=zh_CN.UTF-8

PS1="\[\033[1;36m\]\u\[\033[1;32m\][\w]\[\033[1;33m\]->\[\033[0m\]"
