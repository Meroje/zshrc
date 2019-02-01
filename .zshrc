#!/usr/bin/env zsh

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# prezto
zplug "modules/autosuggestions", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/environment", from:prezto
zplug "modules/git", from:prezto
zplug "modules/history", from:prezto
zplug "modules/history-substring-search/", from:prezto
#zplug "modules/node", from:prezto
zplug "modules/python", from:prezto
#zplug "modules/ruby", from:prezto
zplug "modules/utility", from:prezto

#zplug "plugins/terraform", from:oh-my-zsh, if:"[[ $(command -v terraform) ]]"

zplug "Meroje/zsh-nvm"
zplug "Meroje/zsh-rbenv"

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "modules/syntax-highlighting", from:prezto, defer:2

# Can manage local plugins
zplug "~/.zsh", from:local

# Load theme file
#zplug 'bhilburn/powerlevel9k', as:theme
zplug 'dritter/powerlevel9k', \
    at:async_all_the_segments, \
    as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zstyle ':prezto:module:git:alias' skip 'yes'

# Then, source plugins and add commands to $PATH
zplug load #--verbose

path=(
  ${ZPLUG_BIN:+"$ZPLUG_BIN"}
  "$path[@]"
)

POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_NODE_VERSION_BACKGROUND='022'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='white'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='blue'
# POWERLEVEL9K_FOLDER_ICON="$(print_icon FOLDER_ICON)"
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_COMMIT_ICON="\uf417"
POWERLEVEL9K_K8S_ICON="\u2388"
# POWERLEVEL9K_VCS_UNTRACKED_ICON="$(print_icon VCS_UNSTAGED_ICON)"
# POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON="$(print_icon VCS_INCOMING_CHANGES_ICON)"
# POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="$(print_icon VCS_OUTGOING_CHANGES_ICON)"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=""
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status root_indicator dir dir_writable_joined)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs background_jobs_joined aws kube) # nvm rbenv)

# AWS Profile
# Parameters:
#   * $1 Alignment: string - left|right
#   * $2 Index: integer
#   * $3 Joined: bool - If the segment should be joined
prompt_aws() {
  local profile=${AWS_DEFAULT_PROFILE:-$AWS_PROFILE}

  local bg="green"
  local fg=${DEFAULT_COLOR}

  case "${profile}" in
    *prod) bg="red" ;;
    *staging) bg="022"; fg=${DEFAULT_COLOR_INVERTED} ;;
  esac

  serialize_segment "$0" "" "$1" "$2" "${3}" "${bg}" "${fg}" "${profile}" "AWS_ICON"
}

# Kube context
# Parameters:
#   * $1 Alignment: string - left|right
#   * $2 Index: integer
#   * $3 Joined: bool - If the segment should be joined
prompt_kube() {
  local namespace=$(\kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
  [ "$namespace" != "" ] && namespace="/$namespace"

  local context=$(\kubectl config current-context 2>/dev/null)

  local bg="green"
  local fg=${DEFAULT_COLOR}

  case "${context}" in
    *prod) bg="red" ;;
    *staging) bg="022"; fg=${DEFAULT_COLOR_INVERTED} ;;
  esac

  serialize_segment "$0" "" "$1" "$2" "${3}" "${bg}" "${fg}" "${context}${namespace}" "K8S_ICON"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'
