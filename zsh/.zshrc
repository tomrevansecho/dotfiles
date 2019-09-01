source ~/.aliases

ZSH_THEME="agnoster"

# Autoload screen if we aren't in it.
if [[ $TMUX = '' ]] then tmux; fi

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

export ZSH=$HOME/.oh-my-zsh
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# Set default editor
if [[ -x $(which vim) ]]
then
    export EDITOR="nvim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
fi

source $ZSH/oh-my-zsh.sh
source $ZSH/plugins/git/git.plugin.zsh
