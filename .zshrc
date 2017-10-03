# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="miloshadzic"
ZSH_THEME="simple"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew common-aliases docker docker-compose emoji-clock git git-extras gitignore gpg-agent history jsontools node npm nvm nyan osx react-native rsync ssh-agent terraform vagrant yarn z zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# System setup
export PATH="/Users/Seb/Library/Android/sdk/tools/bin:/usr/local/sbin:/usr/local/bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/gpg-agent/libexec:$PATH:~/bin"

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# brew zsh plugins
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(/usr/local/share/zsh-completions $fpath)
source "/usr/local/opt/zsh-git-prompt/zshrc.sh"
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Better ls
alias l="ls -lha"

# Count files under folders
alias count='for i in *; do [ -d "$i" ] && echo "$i `find "$i" | grep -v .svn | wc -l`"; done | sort -k2 -n'

# Start a simple HTTP server in current dir
alias serve="python -m SimpleHTTPServer"

# App links
#alias vi="/usr/bin/vim"
#alias vim="/usr/local/bin/mvim"
alias ack='ACK_PAGER_COLOR="less -x4SRFX" /usr/local/bin/ack'
alias gitx="open /opt/homebrew-cask/Caskroom/ssp-gitx/0.12/GitX.app --args `pwd`"
alias firefox-profile="/Applications/Firefox.app/Contents/MacOS/firefox -profilemanager"
alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
alias gource='gource --multi-sampling --seconds-per-day 3 --loop --key --user-image-dir .git/avatar/ --follow-user "Seb Flippence"'

alias notify="osascript -e 'display notification \"Done!\" with title \"iTerm\"'"

# Git
alias git-purge='git fetch --all -p && git branch --merged | grep -v "\*" | grep -v master | xargs -n 1 git branch -d'
alias gp="git pull origin && git-purge"
alias gstash="git add . && git stash"
alias gpop="git stash pop && git reset"
alias gignored="git clean -fdXn | sed -e 's/Would remove //g'"
alias gclean="git clean -fdXi"

# Docker
alias fig="docker-compose"
alias fig-kill-rm="fig kill && fig rm -f"
alias docker-restart-stopped="docker restart \$(docker ps -a -q -f status=exited)"
alias docker-rm-stopped="docker rm -v \$(docker ps -a -q -f status=exited)"
alias docker-rm-untagged-images="docker rmi \$(docker images -f 'dangling=true' -q)"
alias docker-gc="docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /etc:/etc spotify/docker-gc"
alias docker-nginx-proxy="docker run -d --name nginx-proxy -p 80:80 --restart="always" -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy"

# Updates, Homebrew & Cask
alias update='mac-up && brew-up && atom-up'
alias mac-up='sudo softwareupdate --install --all'
alias brew-up='brew update && brew upgrade && brew cu -acy && brew cask cleanup && brew cleanup'
alias brew-fix='sudo chown -R $USER /usr/local'
alias atom-up='apm update --confirm false'
alias nvm-up='nvm install node && nvm alias default node'

# GPG
# Add the following to your shell init to set up gpg-agent automatically for every shell
# export GPGKEY=""
export KEYGRIP=$(gpg --fingerprint --fingerprint | grep fingerprint | tail -1 | cut -d= -f2 | sed -e 's/ //g')

gpg_init () {
  if ! pgrep -x "gpg-agent" > /dev/null
  then
      eval $(gpg-agent --daemon)
  fi
}
gpg_init
alias gpg-restart="killall gpg-agent && gpg_init"

# Others
alias change-ssh-pw='ssh-keygen -f ~/.ssh/id_rsa -p'
alias weather='curl -4 wttr.in/London'

if [ -f ~/.bash/extra ]; then
  source ~/.bash/extra
fi
