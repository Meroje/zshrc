POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
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
POWERLEVEL9K_KUBECONTEXT_STAGING_FOREGROUND='white'
POWERLEVEL9K_KUBECONTEXT_OTHER_FOREGROUND=black
POWERLEVEL9K_KUBECONTEXT_OTHER_BACKGROUND=green

POWERLEVEL9K_TERRAFORM_CLASSES=(
  '*prod*'    prod
  '*staging*' staging
  '*'         other)
POWERLEVEL9K_TERRAFORM_PROD_FOREGROUND="$POWERLEVEL9K_KUBECONTEXT_PROD_FOREGROUND"
POWERLEVEL9K_TERRAFORM_PROD_BACKGROUND="$POWERLEVEL9K_KUBECONTEXT_PROD_BACKGROUND"
POWERLEVEL9K_TERRAFORM_STAGING_BACKGROUND="$POWERLEVEL9K_KUBECONTEXT_STAGING_BACKGROUND"
POWERLEVEL9K_TERRAFORM_STAGING_FOREGROUND="$POWERLEVEL9K_KUBECONTEXT_STAGING_FOREGROUND"
POWERLEVEL9K_TERRAFORM_OTHER_FOREGROUND="$POWERLEVEL9K_KUBECONTEXT_OTHER_FOREGROUND"
POWERLEVEL9K_TERRAFORM_OTHER_BACKGROUND="$POWERLEVEL9K_KUBECONTEXT_OTHER_BACKGROUND"

POWERLEVEL9K_AWS_CLASSES=("${POWERLEVEL9K_KUBECONTEXT_CLASSES[@]}")
POWERLEVEL9K_AWS_PROD_FOREGROUND="$POWERLEVEL9K_KUBECONTEXT_PROD_FOREGROUND"
POWERLEVEL9K_AWS_PROD_BACKGROUND="$POWERLEVEL9K_KUBECONTEXT_PROD_BACKGROUND"
POWERLEVEL9K_AWS_STAGING_BACKGROUND="$POWERLEVEL9K_KUBECONTEXT_STAGING_BACKGROUND"
POWERLEVEL9K_AWS_STAGING_FOREGROUND="$POWERLEVEL9K_KUBECONTEXT_STAGING_FOREGROUND"
POWERLEVEL9K_AWS_OTHER_FOREGROUND="$POWERLEVEL9K_KUBECONTEXT_OTHER_FOREGROUND"
POWERLEVEL9K_AWS_OTHER_BACKGROUND="$POWERLEVEL9K_KUBECONTEXT_OTHER_BACKGROUND"
# POWERLEVEL9K_VCS_UNTRACKED_ICON="$(print_icon VCS_UNSTAGED_ICON)"
# POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON="$(print_icon VCS_INCOMING_CHANGES_ICON)"
# POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="$(print_icon VCS_OUTGOING_CHANGES_ICON)"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=""
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status root_indicator dir dir_writable_joined)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs background_jobs_joined terraform aws kubecontext) # nvm rbenv)

prompt_aws() {
  local aws_profile="${AWS_PROFILE:-$AWS_DEFAULT_PROFILE}"
  if [[ -n "$aws_profile" ]]; then
    local pat class
    for pat class in "${POWERLEVEL9K_AWS_CLASSES[@]}"; do
      if [[ $aws_profile == ${~pat} ]]; then
        [[ -n $class ]] && state=_${(U)class}
        break
      fi
    done
    _p9k_prompt_segment "$0$state" red white AWS_ICON 0 '' "${aws_profile//\%/%%}"
  fi
}

function prompt_terraform() {
  (( $+commands[terraform] )) || return
  local ws=default
  if [[ -n $TF_WORKSPACE ]]; then
    ws=$TF_WORKSPACE
  else
    local f=${TF_DATA_DIR:-.terraform}/environment
    [[ -r $f ]] && _p9k_read_file $f && ws=$_p9k_ret
  fi
  ws=${${ws##[[:space:]]#}%%[[:space:]]#}
  local pat class
  for pat class in "${POWERLEVEL9K_TERRAFORM_CLASSES[@]}"; do
    if [[ $ws == ${~pat} ]]; then
      [[ -n $class ]] && state=_${(U)class}
      break
    fi
  done
  [[ $ws == default ]] || _p9k_prompt_segment "$0$state" $_p9k_color1 blue TERRAFORM_ICON 0 '' $ws
}
