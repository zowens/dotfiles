DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true
source "${HOME}/src/github.com/zowens/dotfiles/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/node
    zgen oh-my-zsh plugins/cabal
    zgen oh-my-zsh plugins/npm
    zgen oh-my-zsh plugins/gitfast
    zgen oh-my-zsh plugins/git-extras
    zgen oh-my-zsh plugins/git-remote-branch
    zgen oh-my-zsh plugins/mvn
    zgen oh-my-zsh plugins/brew
    zgen oh-my-zsh plugins/osx
    zgen oh-my-zsh plugins/scala
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/sbt
    zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/gradle
    zgen oh-my-zsh plugins/sudo
    zgen load zsh-users/zsh-syntax-highlighting

    # completions
    zgen load zsh-users/zsh-completions src

    zgen load jimmijj/zsh-syntax-highlighting

    # autosuggestions should be loaded last
    zgen load tarruda/zsh-autosuggestions dist/autosuggestions.zsh

    # save all to init script
    zgen save
fi

autosuggest_start
bindkey '^R' autosuggest-execute-suggestion
autoload -U compinit && compinit

source $(brew --prefix nvm)/nvm.sh

export GOPATH=$HOME
export GOROOT=/usr/local/Cellar/go/`ls /usr/local/Cellar/go/ | head -n 1`/libexec
export PATH=$HOME/Library/Haskell/bin:$HOME/.local/bin:/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.cabal/bin:$GOPATH/bin:$HOME/bin:$HOME/Dropbox/bin
export EDITOR=vim
export RUST_SRC_PATH="/Users/$USER/src/github.com/rust-lang/rust/src"
export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH

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
export GROOVY_HOME=/usr/local/opt/groovy/libexec

rm -f ~/yankring_history_v2.txt

function setjava() {
    vers=$1
    export JAVA_HOME=`/usr/libexec/java_home -v $vers`
}

# set to lowest installed java by default
export LOWEST_JAVA=`ls /Library/Java/JavaVirtualMachines/ | head -n 1 | sed 's/^jdk\(1\.[0-9]*\).*$/\1/'`
setjava $LOWEST_JAVA

function update() {
    echo "$BACKGROUND_RED      Homebrew      $RESET_FORMATTING" && 
    brew update && brew upgrade --all && brew cleanup
    echo "$BACKGROUND_RED        ZGEN        $RESET_FORMATTING" && 
    zgen update
    echo "$BACKGROUND_RED        CABAL       $RESET_FORMATTING" && 
    ((which cabal && cabal update && cabal install cabal-install) || true) &&
    ((which aws && echo "$BACKGROUND_RED       AWS-CLI      $RESET_FORMATTING" && sudo pip3 install awscli --upgrade) || true) &&
    echo "$BACKGROUND_RED        VIM         $RESET_FORMATTING" && 
    (vim -c ":PluginUpdate" -c ":q" -c ":q") &&
    (which rustup && echo "$BACKGROUND_RED        RUST        $RESET_FORMATTING" && rustup)

}
alias brewup='update'

function psrid() {
    psgrep -n $1 | awk '{ print $2 }' | xargs sudo kill -9 {}
}

# Docker
eval "$(docker-machine env dev 2> /dev/null)"
export DOCKER_TLS_VERIFY=0

# for mactex
eval `/usr/libexec/path_helper -s`

if [ -f $HOME/.this_zshrc ] ; then
    source $HOME/.this_zshrc
fi
