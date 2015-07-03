source "${HOME}/src/github.com/zowens/dotfiles/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/node
    zgen oh-my-zsh plugins/cabal
    zgen oh-my-zsh plugins/npm
    zgen oh-my-zsh plugins/git-extras
    zgen oh-my-zsh plugins/github
    zgen oh-my-zsh plugins/git-flow
    zgen oh-my-zsh plugins/mvn
    zgen oh-my-zsh plugins/brew
    zgen oh-my-zsh plugins/osx
    zgen oh-my-zsh plugins/nvm
    zgen oh-my-zsh plugins/scala
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/sbt
    zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/gradle
    zgen oh-my-zsh plugins/sudo
    zgen load zsh-users/zsh-syntax-highlighting

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    # zgen oh-my-zsh themes/arrow

    zgen load jimmijj/zsh-syntax-highlighting

    # autosuggestions should be loaded last
    zgen load tarruda/zsh-autosuggestions

    # save all to init script
    zgen save
fi

## Enable autosuggestions automatically.
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init
bindkey '^R' autosuggest-execute-suggestion

source $(brew --prefix nvm)/nvm.sh

export GOPATH=$HOME
export GOROOT=/usr/local/Cellar/go/`ls /usr/local/Cellar/go/ | head -n 1`/libexec
export PATH=$HOME/Library/Haskell/bin:/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.cabal/bin:$GOPATH/bin:$HOME/bin:$HOME/Dropbox/bin
export EDITOR=vim
export RUST_SRC_PATH="/Users/$USER/src/github.com/rust-lang/rust/src"

export DEFAULT_USER=$USER
source $HOME/.zshprompt

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias c='pbcopy'
alias p='pbpaste'
alias gti='git'
alias xargs='xargs -I {}'
alias newuuid="uuidgen| tr '[:upper:]' '[:lower:]' | pbcopy"

# gradle
alias gw='./gradlew'
GRADLE_OPTS="-Dorg.gradle.daemon=false"

rm -f ~/yankring_history_v2.txt

function setjava() {
    vers=$1
    export JAVA_HOME=`/usr/libexec/java_home -v $vers`
}

# set to lowest installed java by default
export LOWEST_JAVA=`ls /Library/Java/JavaVirtualMachines/ | head | sed 's/^jdk\(1\.[0-9]*\).*$/\1/'`
setjava $LOWEST_JAVA

function update() {
    echo "$BACKGROUND_RED      Homebrew      $RESET_FORMATTING" && 
    brew update && brew upgrade --all && brew cleanup
    echo "$BACKGROUND_RED        ZGEN        $RESET_FORMATTING" && 
    zgen update
}
alias brewup='update'

function psrid() {
    psgrep -n $1 | awk '{ print $2 }' | xargs sudo kill -9 {}
}

function eclimd() {
    psrid eclimd 2> /dev/null
    nohup /Applications/eclipse/eclimd &
}

# Docker
eval "$(docker-machine env dev 2> /dev/null)"
export DOCKER_TLS_VERIFY=0

# for mactex
eval `/usr/libexec/path_helper -s`

export GROOVY_HOME=/usr/local/opt/groovy/libexec

# Oracle
if [ -f /usr/local/share/instantclient/instantclient.sh ] ; then
    source /usr/local/share/instantclient/instantclient.sh
    alias sqlplus='rlwrap sqlplus'
fi

