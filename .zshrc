# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/stian/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

eval "$(starship init zsh)"

# ALIASES
alias r='ranger'
alias sr='sudo ranger'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='cd ~/.config && r'
alias p='sudo pacman -S $1'
alias rec='wf-recorder -g "$(slurp)"'
alias 2pdf='soffice --convert-to pdf *.docx'
alias n='neofetch'
