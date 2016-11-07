if [ -f ~/.bashrc ]; then source ~/.bashrc; fi

# Powerline theme configuration for Bash-it
POWERLINE_PROMPT="clock scm python_venv ruby cwd user_info"
POWERLINE_PROMPT_USER_INFO_MODE="sudo"
BASH_IT_THEME='powerline-plain'

# Tell Bash-it to display information about version control status of current directory
SCM_CHECK=true

# Load Bash It (it needs BASH_IT environment variabile to be set)
BASH_IT=~/.bash_it
source $BASH_IT/bash_it.sh
