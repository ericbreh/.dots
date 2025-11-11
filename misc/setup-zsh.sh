#!/usr/bin/env bash
set -e

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
DOTS_DIR="$HOME/.dots"

# Check if Oh My Zsh is already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Oh My Zsh is not detected. Installing it now."
	echo "This will terminate the script. Run this script again to install plugins."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "Oh My Zsh is detected. Proceeding with plugin installation."

	# Clone Zsh plugins and theme.
	echo "Cloning zsh-autosuggestions..."
	git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

	echo "Cloning fast-syntax-highlighting..."
	git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"

	echo "Cloning powerlevel10k theme..."
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

	# Use stow to link your .zsh files.
	echo "Stowing .zsh configuration from $DOTS_DIR/zsh..."
	if [ -d "$DOTS_DIR" ]; then
		cd "$DOTS_DIR"
		rm -f "$HOME/.zshrc"
		stow -t "$HOME" zsh
	else
		echo "Error: .dots directory not found at $DOTS_DIR. Skipping stow."
		exit 1
	fi

	echo "Setup complete. Please restart your terminal or run 'exec zsh' to apply changes."
fi
