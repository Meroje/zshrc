# -*- mode: shell-script -*-
# vim:ft=zsh

source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

### ZSH Module
if [[ -s "$HOME/.zplugin/bin/zmodules/Src/zdharma/zplugin.so" ]]; then
  module_path+=( "$HOME/.zplugin/bin/zmodules/Src" )
  zmodload zdharma/zplugin
fi

zplugin load zplugin/z-a-bin-gem-node

zplugin ice from"gh-r" fbin"fzf"; zplugin load junegunn/fzf-bin
zplugin ice wait"0" silent trackbinds multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions"
zplugin load junegunn/fzf

zplugin ice svn atpull'zplugin creinstall -q .'; zplugin snippet PZT::modules/git
zplugin snippet PZT::modules/completion/init.zsh
zplugin snippet PZT::modules/directory/init.zsh
zplugin snippet PZT::modules/editor/init.zsh
zplugin snippet PZT::modules/environment/init.zsh
zplugin snippet PZT::modules/history/init.zsh
zplugin snippet PZT::modules/python/init.zsh
zplugin snippet PZT::modules/utility/init.zsh

zplugin ice wait"0" lucid
zplugin load ael-code/zsh-colored-man-pages

zplugin ice wait'1' has'thefuck' lucid aliases trackbinds atload'zstyle ":prezto:runcom" zpreztorc "$HOME/.zshrc"'
zplugin load laggardkernel/zsh-thefuck

zplugin ice has'git' wait'1' lucid fbin"bin/git-dsf"; zplugin load zdharma/zsh-diff-so-fancy
zplugin ice has'git' wait'1' lucid; zplugin load wfxr/forgit
zplugin ice has'git' wait'1' lucid; zplugin load romkatv/gitstatus

zplugin ice wait'0' lucid svn has'terraform' as"completion" atpull'zplugin creinstall -q .'; zplugin snippet OMZ::plugins/terraform
zplugin ice wait'0' lucid has'docker' as"completion" atpull'zplugin creinstall -q .'; zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zplugin ice wait'0' lucid has'docker-compose' as"completion" atpull'zplugin creinstall -q .'; zplugin snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose
zplugin ice wait'0' lucid blockf if'[[ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]]'; zplugin snippet /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
zplugin ice wait'0' lucid if'[[ "$OSTYPE" = *darwin* ]]' atload'!iterm2_precmd'; zplugin snippet https://iterm2.com/shell_integration/zsh

zplugin ice wait'1' lucid; zplugin load hlissner/zsh-autopair

zplugin ice wait'1' lucid; zplugin load lukechilds/zsh-nvm
zplugin ice wait'1' lucid; zplugin load lukechilds/zsh-better-npm-completion

zplugin ice aliases blockf; zplugin load _local/mine

zplugin ice wait'!' nocd atload'!source ~/.p10k.zsh; _p9k_precmd' lucid
zplugin load romkatv/powerlevel10k

zplugin ice wait'0' lucid blockf atpull'zplugin creinstall -q .' lucid
zplugin load zsh-users/zsh-completions

zplugin ice wait'1' lucid compile'{src/*.zsh,src/strategies/*}' atload'!_zsh_autosuggest_start' lucid
zplugin load zsh-users/zsh-autosuggestions

zplugin ice atinit'zpcompinit; zpcdreplay' wait'1c' lucid
zplugin load zdharma/fast-syntax-highlighting

zplugin ice wait'0' lucid
zplugin load zdharma/history-search-multi-word

if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
