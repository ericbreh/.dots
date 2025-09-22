if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then tmux attach -t main || tmux new -s main; fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$ZSH/cache/completions/.zcompdump"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# alias
alias la="ls -A"
alias rcat="command cat"
alias cat="bat"
bindkey -s "^[[108;9u" "ls\n"
alias dots="cd ~/.dots"

# Path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
if [ -f /opt/ros/humble/setup.zsh ]; then source /opt/ros/humble/setup.zsh; fi

eval "$(zoxide init zsh)"
