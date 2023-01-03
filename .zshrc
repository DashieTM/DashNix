if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
########## 

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
#
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.cargo/bin
export GPG_TTY=$TTY 
export TEXMFHOME=$HOME/.texmf
export MANGOHUD_CONFIG=position=top-right,font_scale=0.7,round_corners=10.0
export MOZ_ENABLE_WAYLAND=1
export QT_AUTO_SCREEN_SCALE_FACTOR=0

alias sudo='sudo '
alias ls='lsd'
alias :q='exit'
alias gh='git push origin'
alias gl='git pull origin'
alias gm='git commit -m'

