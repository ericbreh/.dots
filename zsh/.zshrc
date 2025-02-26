# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$ZSH/cache/completions/.zcompdump"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-bat)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fnm
FNM_PATH="/home/ericbreh/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/ericbreh/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# export GPG_TTY=$(tty)

# cse 293
export PATH=$PATH:~/Utils/oss-cad-suite/bin
export PATH=$PATH:~/Utils/zachjs-sv2v
export PATH=$PATH:~/Utils/verible-v0.0-3831-g32b2456e/bin
export PATH=$PATH:~/Utils/Xilinx/Vivado/2024.2/bin

(cat ~/.cache/wal/sequences &)
# source ~/.cache/wal/colors-tty.sh