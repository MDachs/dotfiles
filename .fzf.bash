# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/meik/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/meik/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/meik/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/meik/.fzf/shell/key-bindings.bash"
