#!/usr/bin/env zsh

fpath=(
"${${(%):-%N}:A:h}"/autoload(N-/)
$fpath
)
autoload -Uz zsh_plugin
setopt promptsubst

unalias run-help 2>/dev/null
autoload run-help
if (( $+commands[brew] )) && [[ -d "$(brew --prefix zsh 2>/dev/null)" ]]; then
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

# Source module files.
source "${0:h}/alias.zsh"