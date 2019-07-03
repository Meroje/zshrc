#!/usr/bin/env zsh

fpath=(
  "${${(%):-%N}:A:h}"/autoload(N-/)
  $fpath
)

setopt promptsubst complete_aliases

unalias run-help 2>/dev/null
autoload run-help
if [[ -d "/usr/local/opt/zsh" ]]; then
  HELPDIR="/usr/local/opt/zsh/share/zsh/help"
elif (( $+commands[brew] )) && [[ -d "$(brew --prefix zsh 2>/dev/null)" ]]; then
  HELPDIR="$(brew --prefix zsh)/share/zsh/help"
else
  HELPDIR="/usr/share/zsh/5.2/help"
fi

if (( $+commands[thefuck] )); then
  eval $(thefuck -a)
fi

if (( $+commands[pipenv] )); then
#  eval $(env _PIPENV_COMPLETE=source-zsh pipenv)
  autoload -U compinit
  _pipenv() {
    eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIPENV_COMPLETE=complete-zsh  pipenv)
  }
  compdef _pipenv pipenv
fi

if (( $+commands[hub] )); then
  eval "$(hub alias -s)"
fi

if (( $+commands[helm] )); then
  source <(\helm completion zsh)
fi

if (( $+commands[kops] )); then
  source <(\kops completion zsh)
fi

if [[ -d "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]]; then
#  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
#  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi

alias ssh='ssh -A -Y -C'
alias sf='php -C -d date.timezone=UTC -d memory_limit=-1 bin/console'
alias gs='git status'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpc='git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'
alias gcf='git commit --amend --reuse-message HEAD'
compdef _git gs=git gp=git gpf=git gpc=git gcf=git
