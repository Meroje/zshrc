#!/usr/bin/env zsh

fpath=(
  "${${(%):-%N}:A:h}"/autoload(N-/)
  $fpath
)
autoload -Uz zsh_plugin
setopt promptsubst

unalias run-help 2>/dev/null
autoload run-help
if (( $+commands[brew] )) && [[ -d "/usr/local/opt/zsh" ]]; then
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
  eval $(env _PIPENV_COMPLETE=source-zsh pipenv)
fi

if (( $+commands[hub] )); then
  eval "$(hub alias -s)"
fi

if [[ -d "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]]; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi

alias ssh='ssh -A -Y -C'
alias sf='php -C -d date.timezone=UTC -d memory_limit=-1 bin/console'
alias gs='git status'

