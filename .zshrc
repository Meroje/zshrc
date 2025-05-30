# -*- mode: shell-script -*-
# vim:ft=zsh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

### ZSH Module
if [[ -e "$ZINIT_HOME/../module/Src/zdharma_continuum/zinit.bundle" ]]; then
  module_path+=( "$ZINIT_HOME/../module/Src" )
  zmodload zdharma_continuum/zinit
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
  zdharma-continuum/zinit-annex-{'readurl','bin-gem-node','patch-dl','rust'}

zinit ice from"gh-r" fbin"fzf"; zinit load junegunn/fzf-bin
zinit ice wait"0" silent trackbinds multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions"
zinit load junegunn/fzf

zinit ice svn atpull'zinit creinstall -q .'; zinit snippet PZT::modules/git
zinit snippet PZT::modules/completion/init.zsh
zinit snippet PZT::modules/directory/init.zsh
zinit snippet PZT::modules/editor/init.zsh
zinit snippet PZT::modules/environment/init.zsh
zinit snippet PZT::modules/history/init.zsh
zinit snippet PZT::modules/python/init.zsh
zinit snippet PZT::modules/utility/init.zsh
zinit snippet OMZ::lib/key-bindings.zsh

zinit ice wait"0" lucid
zinit load ael-code/zsh-colored-man-pages

#zinit ice wait'1' has'thefuck' lucid aliases trackbinds atload'zstyle ":prezto:runcom" zpreztorc "$HOME/.zshrc"'
#zinit load laggardkernel/zsh-thefuck

zinit ice has'git' wait'1' lucid; zinit load zdharma-continuum/zsh-diff-so-fancy
zinit ice has'git' wait'1' lucid; zinit load wfxr/forgit
zinit ice has'git' wait'1' lucid; zinit load romkatv/gitstatus

zinit ice wait'0' lucid svn has'terraform' as"completion" atpull'zinit creinstall -q .'; zinit snippet OMZ::plugins/terraform
zinit ice wait'0' lucid has'docker' as"completion" atpull'zinit creinstall -q .'; zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zinit ice wait'0' lucid has'docker-compose' as"completion" atpull'zinit creinstall -q .'; zinit snippet https://github.com/docker/compose/blob/v1/contrib/completion/zsh/_docker-compose
zinit ice wait'0' lucid blockf if'[[ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]]'; zinit snippet /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
zinit ice wait'0' lucid if'[[ "$OSTYPE" = *darwin* && "$TERM" != "xterm-kitty" ]]' atload'!iterm2_precmd'; zinit snippet https://iterm2.com/shell_integration/zsh
zinit ice wait'0' lucid if'[[ "$OSTYPE" = *darwin* && "$TERM" == "xterm-kitty" ]]' atinit'export KITTY_SHELL_INTEGRATION="enabled"'; zinit snippet "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty.zsh

zinit ice wait'1' lucid; zinit load hlissner/zsh-autopair

zinit ice wait'1' lucid; zinit load lukechilds/zsh-nvm
zinit ice wait'1' lucid; zinit load lukechilds/zsh-better-npm-completion

zinit ice aliases blockf; zinit load _local/mine

zinit env-whitelist 'P9K_*'
zinit ice wait'!0' nocd atload'!source ~/.p10k.zsh; _p9k_precmd' wrap'_p9k_precmd' lucid
zinit load romkatv/powerlevel10k

zinit ice wait'0' lucid blockf atpull'zinit creinstall -q .' lucid
zinit load zsh-users/zsh-completions

zinit ice wait'1' lucid compile'{src/*.zsh,src/strategies/*}' atload'!_zsh_autosuggest_start' lucid
zinit load zsh-users/zsh-autosuggestions

zinit ice atinit'zicompinit; zicdreplay' wait'1c' lucid
zinit load zdharma-continuum/fast-syntax-highlighting

zinit ice wait'0' lucid
zinit load zdharma-continuum/history-search-multi-word

if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

