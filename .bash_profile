if [ -f ~/.bashrc ]; then source ~/.bashrc; fi

# Powerline theme configuration for Bash-it
POWERLINE_PROMPT="scm cwd"
BASH_IT_THEME='powerline-plain'

# Tell Bash-it to display information about version control status of current directory
SCM_CHECK=true

# Load Bash It (it needs BASH_IT environment variabile to be set)
BASH_IT=~/.bash_it
source $BASH_IT/bash_it.sh
export PATH="/usr/local/sbin:$PATH"
