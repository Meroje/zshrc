#!/usr/bin/env zsh

#source ~/.zplug_mine
source ~/.zplugin_mine

if [[ $(whence -w prompt_powerlevel9k_setup) =~ "function" ]]; then
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
fi

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# bind -x '"\C-p": vim $(fzf);'
