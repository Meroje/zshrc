#!/usr/bin/env zsh

#source ~/.zplug_mine
source ~/.zplugin_mine

if [[ $(whence -w prompt_powerlevel9k_setup) =~ "function" ]]; then
  POWERLEVEL9K_MODE='nerdfont-complete'
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=''
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
  POWERLEVEL9K_VCS_COMMIT_ICON='\uf417'
  # POWERLEVEL9K_K8S_ICON="\u2388"
  POWERLEVEL9K_KUBECONTEXT_SHOW_DEFAULT_NAMESPACE=false
  POWERLEVEL9K_KUBECONTEXT_CLASSES=(
    '*prod*'    prod
    '*staging*' staging
    '*'         other)
  POWERLEVEL9K_KUBECONTEXT_PROD_FOREGROUND=black
  POWERLEVEL9K_KUBECONTEXT_PROD_BACKGROUND=red
  POWERLEVEL9K_KUBECONTEXT_STAGING_BACKGROUND='022'
  POWERLEVEL9K_KUBECONTEXT_OTHER_FOREGROUND=black
  POWERLEVEL9K_KUBECONTEXT_OTHER_BACKGROUND=green
  # POWERLEVEL9K_VCS_UNTRACKED_ICON="$(print_icon VCS_UNSTAGED_ICON)"
  # POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON="$(print_icon VCS_INCOMING_CHANGES_ICON)"
  # POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="$(print_icon VCS_OUTGOING_CHANGES_ICON)"
  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
  POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=""
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status root_indicator dir dir_writable_joined)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs background_jobs_joined terraform aws kubecontext) # nvm rbenv)

  # AWS Profile
  # Parameters:
  #   * $1 Alignment: string - left|right
  #   * $2 Index: integer
  #   * $3 Joined: bool - If the segment should be joined
  prompt_aws() {
    local aws_profile=${AWS_DEFAULT_PROFILE:-$AWS_PROFILE}

    local bg="green"
    local fg=${DEFAULT_COLOR}

    case "${aws_profile}" in
      *prod) bg="red" ;;
      *staging) bg="022"; fg=${DEFAULT_COLOR_INVERTED} ;;
    esac

    #serialize_segment "$0" "" "$1" "$2" "${3}" "${bg}" "${fg}" "${profile}" "AWS_ICON"
    if [[ -n $aws_profile ]]; then
      "$1_prompt_segment" "$0" "$2" "${bg}" "${fg}" 'AWS_ICON' 0 '' "${aws_profile//\%/%%}"
    fi
  }

  # Terraform workspace
  # Parameters:
  #   * $1 Alignment: string - left|right
  #   * $2 Index: integer
  #   * $3 Joined: bool - If the segment should be joined
  prompt_terraform() {
    local profile="$(cat .terraform/environment 2>/dev/null || echo '')"

    local bg="green"
    local fg=${DEFAULT_COLOR}

    case "${profile}" in
      *prod*) bg="red" ;;
      *staging*) bg="022"; fg=${DEFAULT_COLOR_INVERTED} ;;
    esac

    #serialize_segment "$0" "" "$1" "$2" "${3}" "${bg}" "${fg}" "${profile}" "TERRAFORM_ICON"
    if [[ -n $profile ]]; then
      "$1_prompt_segment" "$0" "$2" "${bg}" "${fg}" 'TERRAFORM_ICON' 0 '' "${profile//\%/%%}"
    fi
  }
fi

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# bind -x '"\C-p": vim $(fzf);'
#
