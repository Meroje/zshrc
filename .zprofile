# Linux shim
XDG_CONFIG_HOME="$HOME/.config"

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
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
cdpath=(
  /usr/local/var/www
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  "$HOME/bin"
  "$HOME/.composer/vendor/bin"
  /usr/local/opt/go/libexec/bin
  "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/"
  /usr/local/{bin,sbin}
  $path
)

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="$(mktemp -d)"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

# tie DYLD_LIBRARY_PATH to the array ldpath
export -TU DYLD_LIBRARY_PATH ldpath
export -TU PYTHONPATH python_path
export -TU GEM_PATH gem_path

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Set NVM_DIR to home instead of brew prefixed path
NVM_DIR="${HOME}/.nvm"

FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
