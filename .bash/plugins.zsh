source ~/.bash/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.bash/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
if [[ $OSTYPE == 'darwin'* ]]; then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
else
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
fi

source ~/.bash/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.bash/plugins/zsh-npm-scripts-autocomplete/zsh-npm-scripts-autocomplete.plugin.zsh
source ~/.bash/plugins/zsh-z/zsh-z.plugin.zsh
