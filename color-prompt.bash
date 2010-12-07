PS1="${PS1%" "}" # chomp last space if available

# checksum from hostname, e.g. 4235697493
cksum_of_hostname="$(hostname | cksum | cut -d " " -f 1 )"
cksum_of_hostname_in_octal="$(printf '%o' "$cksum_of_hostname" )"
last_digit="${cksum_of_hostname_in_octal: -1}"
a_deterministic_value_from_0_to_7_from_hostname="$last_digit"
color_to_be_used="$a_deterministic_value_from_0_to_7_from_hostname"

color_prologue='\[\e[1;3'"$color_to_be_used"'m\]'
color_epilogue='\[\e[0m\] '
PS1="$color_prologue$PS1$color_epilogue"

