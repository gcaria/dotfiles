# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Local paths stored for convenience
export LI="$HOME/usr/local"
export NC="$HOME/neuro-clouds"
export ST="/homedata/gcaria"

# Update PATH
export PATH="$LI/bin:$HOME/.local/bin:$PATH"
export PATH="$PATH:$NC/scripts"
export PATH="$PATH:$HOME/scripts"
# Set PYTHONPATH
export PYTHONPATH="$NC/packages"

# Set paths for local installations
export LDFLAGS="-L$LI/lib -L$LI/lib64"
export CPPFLAGS="-I$LI/include"
export PKG_CONFIG_PATH="$LI/lib/pkgconfig:$LI/lib64/pkgconfig"
export LD_LIBRARY_PATH="$LI/lib:$LI/lib64:$LD_LIBRARY_PATH"

# export PAGER="$LI/bin/vimpager"


# Change from french to english
export LANG=en_US.UTF-8

export MATPLOTLIBRC="$HOME/.config/matplotlib"

export FORTUNE_FILE="$HOME/.fortune/fortunes"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt SHARE_HISTORY

# Make mysterious oh-my-zsh errors disappear
export FPATH=$LI/share/zsh/5.8/functions:$FPATH
export ZSH="/home/gcaria/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

d=/home/gcaria/.dircolors
test -r $d && eval "$(dircolors $d)"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

plugins=(git colored-man-pages zsh-syntax-highlighting zsh-autosuggestions)

DISABLE_MAGIC_FUNCTIONS=true

source $ZSH/oh-my-zsh.sh

# don't ask for confirmation when rm -f
setopt rmstarsilent

export EDITOR='vim'
bindkey -v

# enable suggestion for correction of commands
setopt correct
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color ? [Yes, No, Abort, Edit] "

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.profile

module purge
module load gnu/7.2.0

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

# Setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Setup virtualenvwrapper (extension to virtualenv)
source $HOME/.virtualenvwrapper

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
# pyenv virtualenvwrapper_lazy

cd $NC
workon neuro-clouds
