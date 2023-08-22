# Setup fzf
# ---------
if [[ ! "$PATH" == */home/granted/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/granted/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/granted/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/granted/.fzf/shell/key-bindings.bash"
