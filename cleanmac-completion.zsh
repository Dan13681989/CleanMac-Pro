#compdef cleanmac
_cleanmac() {
    local -a commands
    commands=(
        'clean:Run system cleaner'
        'dashboard:Launch interactive TUI'
        'analyze:Analyze disk usage'
        'large-files:Find large files'
        'docker:Clean Docker space'
        'security:Run security scan'
        'network:Network tools'
        'uninstall:Remove CleanMac Pro'
        'upgrade:Self-upgrade'
        'version:Show version'
        'help:Show help'
    )
    if (( CURRENT == 2 )); then
        _describe -t commands 'cleanmac commands' commands
    elif (( CURRENT == 3 )) && [[ $words[2] == "network" ]]; then
        local -a network_cmds=(
            'status:Show network status'
            'flush-dns:Flush DNS cache'
            'optimize:Apply DNS+TCP optimizations'
            'reset:Reset TCP to defaults'
            'monitor:Launch network monitor'
        )
        _describe -t network_cmds 'network commands' network_cmds
    fi
}
compdef _cleanmac cleanmac
