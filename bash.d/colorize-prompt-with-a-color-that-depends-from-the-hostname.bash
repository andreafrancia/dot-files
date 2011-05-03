PS1="${PS1%" "}" # chomp last space if available

foreground_color=2
background_color=0

set_foreground="\e[1;3${foreground_color}m"
set_background="\e[4${background_color}m"
color_prologue='\['"${set_foreground}${set_background}\]"
no_color='\e[0m'
color_epilogue='\['"$no_color"'\]'
PS1="$color_prologue$PS1$color_epilogue "

