# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# The following lines were added by compinstall
zstyle :compinstall filename '/home/dashie/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
#[ -f "/home/dashie/.ghcup/env" ] && source "/home/dashie/.ghcup/env" # ghcup-env
[ -f "/home/dashie/.ghcup/env" ] && source "/home/dashie/.ghcup/env" # ghcup-env
export PATH=$PATH:~/.local/bin
export GPG_TTY=$TTY
#export KWIN_X11_REFRESH_RATE=180000
#export KWIN_X11_NO_SYNC_TO_VBLANK=0
#export KWIN_X11_FORCE_SOFTWARE_VSYNC=1
export MANGOHUD_CONFIG=position=top-right,font_scale=0.7,round_corners=10.0
export MOZ_ENABLE_WAYLAND=1
alias update='/home/dashie/Documents/scripts/update.sh'
alias sudo='sudo '
alias ls='lsd'
