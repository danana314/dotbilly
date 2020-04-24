# Setup fzf
# ---------
if [[ ! "$PATH" == */home/adnaan/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/adnaan/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/adnaan/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/adnaan/.fzf/shell/key-bindings.zsh"
