main() {

PS1="${PS1%" "}" # chomp last space if available

color_to_be_used="$(hostname_to_octal)"

foreground="\e[3$((color_to_be_used))m"
background="\e[4$(( 7 ))m"
color_prologue='\['"${foreground}${background}\]"
no_color='\e[0m'
color_epilogue='\['"$no_color"'\] '
PS1="$color_prologue$PS1$color_epilogue"
}


hostname_to_octal() {
	cksum_of_hostname="$(echo "$HOSTNAME" | cksum | cut -d " " -f 1 )"
	cksum_of_hostname_in_octal="$(printf '%o' "$cksum_of_hostname" )"
	last_digit="${cksum_of_hostname_in_octal:-1}"
	echo "$last_digit"
}

main

