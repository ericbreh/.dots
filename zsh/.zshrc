# To install Oh My Zsh, plugins, and theme
# chsh -s $(which zsh)
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

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

# Path
export PATH="/home/ericbreh/.local/bin:$PATH"

# fnm
FNM_PATH="/home/ericbreh/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/ericbreh/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# cse 293
export PATH=$PATH:~/Utils/oss-cad-suite/bin
export PATH=$PATH:~/Utils/zachjs-sv2v
export PATH=$PATH:~/Utils/verible-v0.0-3831-g32b2456e/bin
export PATH=$PATH:~/Utils/xschem/bin
export PATH=$PATH:~/Utils/netgen/bin

export PDK_ROOT=~/.volare

export CHROME_EXECUTABLE=$(which brave-browser)
export PATH=$PATH:~/Utils/flutter/bin

alias la='ls -A'
alias rcat="command cat"
alias cat="bat"