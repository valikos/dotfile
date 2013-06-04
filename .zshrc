PROMPT='%B%F{green}%n@%m%f:%F{blue}%~%f%b%(!.#.$) '

autoload -U compinit
compinit

zmodload zsh/complist
zstyle ':completion:*' menu yes select

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

setopt AUTO_CD BSD_ECHO

_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}

zstyle ':completion:::::' completer _force_rehash _complete

setopt SH_WORD_SPLIT #РїСЂРѕР±РµР»С‹ РєР°Рє РІ bash

if [ -e $HOME/.ssh/known_hosts ] ; then
  hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*})
  zstyle ':completion:*:hosts' hosts $hosts
fi

typeset -U path cdpath fpath manpath

autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey "^X^Z" predict-on # C-x C-z
bindkey "^Z" predict-off # C-z

autoload -U zcalc zed

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt APPEND_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

bindkey '^[[3~' delete-char
bindkey '^E' expand-cmd-path

alias df='df -h'
alias du='du -sh'
alias grep='egrep --color=auto'

hash -d data=/Volumes/Data\ HD/
hash -d itunes=/Volumes/Data\ HD/Music/iTunes\ Music/

[ -r /etc/debian_version ] && [ -x 'which sudo' ] && alias upgrade='sudo apt-get update && sudo apt-get -u upgrade'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"
