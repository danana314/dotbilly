# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
# PS1="%B%{$fg[red]%}[%{$fg[green]%}%n %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load aliases and shortcuts if existent.
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
# [ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

bindkey -s '^a' 'bc -l\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# aliases
alias ls='ls --color=auto --group-directories-first'
alias dev='cd ~/workspace/smarkets && source tools/dev/setup/activate.sh'
alias cds='cd ~/workspace/smarkets'

eval `cat ~/.fehbg`

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Use ag for feeding into fzf for searching files.
export FZF_DEFAULT_COMMAND='ag -U --hidden --ignore .git -g ""'
# Color: https://github.com/junegunn/fzf/wiki/Color-schemes - Solarized Dark
# Bind F1 key to toggle preview window on/off
export FZF_DEFAULT_OPTS='--bind "F1:toggle-preview" --preview "rougify {} 2> /dev/null || cat {} 2> /dev/null || tree -C {} 2> /dev/null | head -100" --color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254 --color info:254,prompt:37,spinner:108,pointer:235,marker:235'

# Show long commands if needed
# From https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
# Bind F1 key to toggle preview window on/off
export FZF_CTRL_R_OPTS='--bind "F1:toggle-preview" --preview "echo {}" --preview-window down:3:hidden:wrap'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-git-prompt/zshrc.sh
# PROMPT='%B%m%~%b$(git_super_status) %# '
PS1="%B%{$fg[blue]%}[%{$fg[green]%}%1~%{$fg[blue]%}]%b %(!.#.>) "
RPROMPT='$(git_super_status)'
# Load zsh-syntax-highlighting; should be last.
source /home/adnaan/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval $(thefuck --alias)