# Store initial shell level only if not already set
if [[ -z "$_INITIAL_SHLVL" ]]; then
    export _INITIAL_SHLVL=${SHLVL:-1}
fi

# Track if we've shown our first prompt yet
if [[ -z "$_PROMPT_COUNT" ]]; then
    export _PROMPT_COUNT=0
fi

function add_newline_before_prompt() {
    ((_PROMPT_COUNT++))

    # Skip newline on very first prompt
    if [[ $_PROMPT_COUNT -eq 1 ]]; then
        return
    fi

    # Skip newline after clear command
    if [[ "$LAST_COMMAND" == "clear" ]]; then
        return
    fi

    # Skip newline when SHLVL increased (we're in a nested shell)
    # and this is the first prompt since the nesting occurred
    if [[ ${SHLVL:-1} -gt ${_INITIAL_SHLVL:-1} ]] && [[ $_PROMPT_COUNT -eq 1 ]]; then
        return
    fi

    # Add the newline
    echo ""
}

function track_command() {
    LAST_COMMAND="$1"
}

# Only add to function arrays if not already present
if [[ ! " ${precmd_functions[*]} " =~ " add_newline_before_prompt " ]]; then
    precmd_functions+=(add_newline_before_prompt)
fi

if [[ ! " ${preexec_functions[*]} " =~ " track_command " ]]; then
    preexec_functions+=(track_command)
fi
