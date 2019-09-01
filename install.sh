#!/bin/sh

CURRENT_FILE_PATH="$(pwd)/$(dirname $0)"
export DOTFILES_PATH=${CURRENT_FILE_PATH%"/."}

# Homebrew Script for OSX
# To execute: save and `chmod +x ./install.sh` then `./install.sh`

echo "Installing homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update homebrew recipes
brew update

echo "Brew fun..."
# All apps (This line is 2 times because there are dependencies between brew cask and brew)
brew bundle --file="$DOTFILES_PATH/brew/Brewfile"
brew bundle --file="$DOTFILES_PATH/brew/Brewfile"

echo "Setting up mac os..."
sh "$DOTFILES_PATH/mac/install.sh"

#bash
echo "Setting up bash..."
ln -s -i "$DOTFILES_PATH/bash/.bashrc" "$HOME/.bashrc"
ln -s -i "$DOTFILES_PATH/bash/.aliases" "$HOME/.aliases"

#zsh
echo "Setting up zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s -i "$DOTFILES_PATH/zsh/.zshrc" "$HOME/.zshrc"

#neovim
echo "Setting up neovim.."
mkdir -p "$HOME/.config/nvim"
ln -s -i "$DOTFILES_PATH/neovim/init.vim" "$HOME/.config/nvim/init.vim"

#tmux
echo "Setting up tmux.."
ln -s -i "$DOTFILES_PATH/tmux/.tmux.conf" "$HOME/.tmux.conf"

#GIT
echo "Setting up GIT.."
ln -s -i "$DOTFILES_PATH/git/.gitconfig" "$HOME/.gitconfig"
ln -s -i "$DOTFILES_PATH/git/.gitconfig" "$HOME/.gitignore_global"

#cocoapods
echo "Setting up Cocoapods for iOS development"
gem install cocoapods --user-install

#iTerm2 theme
cd ..
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh

cd ..

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Change default terminal to ZSH
chsh -s "$(command -v zsh)"

# Create the autojump historic file
touch "$HOME/.z"

echo "Setup complete"