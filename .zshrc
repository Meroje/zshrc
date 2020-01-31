# -*- mode: shell-script -*-
# vim:ft=zsh

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### ZSH Module
if [[ -s "$HOME/.zinit/bin/zmodules/Src/zdharma/zinit.so" ]]; then
  module_path+=( "$HOME/.zinit/bin/zmodules/Src" )
  zmodload zdharma/zinit
fi

zinit load zinit-zsh/z-a-bin-gem-node

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

zinit ice has'git' wait'1' lucid fbin"bin/git-dsf"; zinit load zdharma/zsh-diff-so-fancy
zinit ice has'git' wait'1' lucid; zinit load wfxr/forgit
zinit ice has'git' wait'1' lucid; zinit load romkatv/gitstatus

zinit ice wait'0' lucid svn has'terraform' as"completion" atpull'zinit creinstall -q .'; zinit snippet OMZ::plugins/terraform
zinit ice wait'0' lucid has'docker' as"completion" atpull'zinit creinstall -q .'; zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zinit ice wait'0' lucid has'docker-compose' as"completion" atpull'zinit creinstall -q .'; zinit snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose
zinit ice wait'0' lucid blockf if'[[ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]]'; zinit snippet /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
zinit ice wait'0' lucid if'[[ "$OSTYPE" = *darwin* ]]' atload'!iterm2_precmd'; zinit snippet https://iterm2.com/shell_integration/zsh

zinit ice wait'1' lucid; zinit load hlissner/zsh-autopair

zinit ice wait'1' lucid; zinit load lukechilds/zsh-nvm
zinit ice wait'1' lucid; zinit load lukechilds/zsh-better-npm-completion

zinit ice aliases blockf; zinit load _local/mine

zinit ice wait'!' nocd atload'!source ~/.p10k.zsh; _p9k_precmd' lucid
zinit load Meroje/powerlevel10k

zinit ice wait'0' lucid blockf atpull'zinit creinstall -q .' lucid
zinit load zsh-users/zsh-completions

zinit ice wait'1' lucid compile'{src/*.zsh,src/strategies/*}' atload'!_zsh_autosuggest_start' lucid
zinit load zsh-users/zsh-autosuggestions

zinit ice atinit'zpcompinit; zpcdreplay' wait'1c' lucid
zinit load zdharma/fast-syntax-highlighting

zinit ice wait'0' lucid
zinit load zdharma/history-search-multi-word

if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

