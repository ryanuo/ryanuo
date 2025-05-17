# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh" # macOS
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="random"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# Nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Rust configuration
export PATH="$HOME/.cargo/bin:$PATH"

# Load aliases from .alias file
if [ -f ~/.alias ]; then
    source ~/.alias
fi

# Load pyenv
export PYTHON_BUILD_MIRROR_URL_SKIP_CHECKSUM=1
export PYTHON_BUILD_MIRROR_URL="https://registry.npmmirror.com/-/binary/python"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# c# path
export PATH="/usr/local/share/dotnet:$PATH"