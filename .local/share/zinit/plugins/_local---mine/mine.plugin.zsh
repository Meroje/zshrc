# According to the Zsh Plugin Standard:
# http://zdharma.org/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

fpath+="${0:A:h}"

setopt promptsubst complete_aliases

autoload run-help

if (( $+commands[pipenv] )); then
  _pipenv() {
    eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIPENV_COMPLETE=complete-zsh pipenv)
  }
  compdef _pipenv pipenv
fi

if (( $+commands[hub] )); then
  alias git=hub
fi

alias ssh='ssh -A -Y -C'
alias sf='php -C -d date.timezone=UTC -d memory_limit=-1 bin/console'
alias gs='git status'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpc='git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'
alias gcf='git commit --amend --reuse-message HEAD'
compdef _git gs=git gp=git gpf=git gpc=git gcf=git

alias rsync-copy='rsync -avz --info=progress2 -h'
alias rsync-move='rsync -avz --info=progress2 -h --remove-source-files'
alias rsync-synchronize='rsync -avzu --delete --info=progress2 -h'
alias rsync-update='rsync -avzu --info=progress2 -h'
compdef _rsync rsync-copy=rsync rsync-move=rsync rsync-synchronize=rsync rsync-update=rsync

if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh)
fi
if (( $+commands[eksctl] )); then
  source <(eksctl completion zsh)
fi
if (( $+commands[kops] )); then
  source <(kops completion zsh)
fi
if (( $+commands[helm] )); then
  source <(helm completion zsh)
fi
if (( $+commands[pkgx] )); then
  source <(pkgx dev --shellcode)
fi
if (( $+commands[vault] )); then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/local/bin/vault vault
fi
if [ -e /usr/local/opt/curl/bin/curl ]; then
    path=(
        /usr/local/opt/curl/bin
        $path
    )
    manpath=(
        /usr/local/opt/curl/share/man
        $manpath
    )
fi
if [ -f /usr/local/opt/switch/switch.sh ]; then
    source /usr/local/opt/switch/switch.sh
    alias kubectx=switch
fi
if [ -f ~/.local/share/tinted-theming/tinty/repos/fzf/ansi/ansi.sh ]; then
    source ~/.local/share/tinted-theming/tinty/repos/fzf/ansi/ansi.sh
fi
