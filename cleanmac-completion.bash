_cleanmac() {
    local cur prev words cword
    _init_completion || return
    case $cword in
        1)
            COMPREPLY=($(compgen -W "clean dashboard analyze large-files docker security network uninstall upgrade version help" -- "$cur"))
            ;;
        2)
            if [[ ${words[1]} == "network" ]]; then
                COMPREPLY=($(compgen -W "status flush-dns optimize reset monitor help" -- "$cur"))
            fi
            ;;
    esac
}
complete -F _cleanmac cleanmac
