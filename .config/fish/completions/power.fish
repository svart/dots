complete -c power -f
complete -c power -n __fish_is_first_arg -a performance -d 'Firmware performance profile (higher power limits)'
complete -c power -n __fish_is_first_arg -a balanced -d 'Re-apply TLP config (balanced on AC)'
complete -c power -n __fish_is_first_arg -a status -d 'Show current profile'
complete -c power -n __fish_is_first_arg -a fullcharge -d 'Charge battery to 100% once (needs AC)'
