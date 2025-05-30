# Bring in the default PATH from /etc/paths /etc/paths.d
[[ -x /usr/libexec/path_helper ]] && eval $(/usr/libexec/path_helper -s)

export HOMEBREW_INSTALL_FROM_API=1
if [[ $(arch) = "arm64" ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi
if [[ $(arch) = "i386" ]]; then
    eval $(/usr/local/bin/brew shellenv)
fi

# Linux shim
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

#
# Locale
#
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

#
# Editors
#
export EDITOR='vim'
export GIT_EDITOR="${EDITOR}"
export VISUAL='subl -w'
export PAGER='less'


#
# Golang
#
export GOPATH=$HOME/go
export GOTRACEBACK=all

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path infopath manpath

# Set the the list of directories that cd searches.
cdpath=(
  /usr/local/var/www
  $cdpath
)

fpath=(
  "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions"
  $fpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "${KREW_ROOT:-$HOME/.krew}/bin"
  "$HOME/.composer/vendor/bin"
  "$HOME/.config/composer/vendor/bin"
  "$HOME/.cargo/vendor/bin"
  "$HOME/.cabal/bin"
  "$HOME/.cargo/bin"
  "$HOME/.jsvu"
  "$GOPATH/bin" "$GOPATH/bin/darwin_amd64" "$HOMEBREW_PREFIX/opt/go/libexec/bin" "$HOMEBREW_PREFIX/opt/go/libexec/misc/wasm"
  "$HOME/Library/Python/3.13/bin"
  "$HOME/Library/Python/3.12/bin"
  "$HOME/Library/Python/3.11/bin"
  "$HOME/Library/Python/3.10/bin"
  "$([[ -x /usr/libexec/java_home ]] && /usr/libexec/java_home -F 2>/dev/null)"
# "$(gem env gemdir)/bin"
# /usr/local/{bin,sbin}
  $path
)

manpath=(
  $HOME/man
  $HOMEBREW_PREFIX/share/man # Homebrew
  /usr/local/opt/erlang/lib/erlang/man # erlang
  /opt/X11/share/man
  $manpath # Other setup files
  $([[ -r /etc/manpaths ]] && /bin/cat /etc/manpaths) # Default manpaths - not loaded by default
)
# ZSH doesn't do this automatically, it does fill from $manpath though
export MANPATH

infopath=(
# /usr/local/share/info # Homebrew
  $infopath
)

export GROOVY_HOME="$HOMEBREW_PREFIX/opt/groovy/libexec"

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="$(mktemp -d)"
fi

export TMPPREFIX="${TMPDIR%/}/zsh"

# tie DYLD_LIBRARY_PATH to the array ldpath
export -TU DYLD_LIBRARY_PATH ldpath
export -TU PYTHONPATH python_path
export -TU GEM_PATH gem_path

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
export HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
export COMPLETION_WAITING_DOTS="true"

# Set NVM_DIR to home instead of brew prefixed path
export NVM_NO_USE=true
export NVM_DIR="${HOME}/.nvm"
export NVM_LAZY_LOAD="true"

# Rbenv
export DISABLE_AUTO_UPDATE="true"
export RBENV_LAZY_LOAD="true"

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168
'

# Output timing info for slow commands
export REPORTTIME=5

# Update homebrew every 24h
export HOMEBREW_AUTO_UPDATE_SECS="86400"

# AWS assumed roles
export AWS_SDK_LOAD_CONFIG=true

# colored ls on macOS
export CLICOLOR=true

# autosuggestions
#export ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd history)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_MANUAL_REBIND=true

# ripgrep
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/config

# hashicorp telemetry
export CHECKPOINT_DISABLE=1

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
