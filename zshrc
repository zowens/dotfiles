DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

#source "${HOME}/src/github.com/zowens/dotfiles/zgen.zsh"
if ! [ -f $HOME/.this_zshrc ] ; then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi
source "${HOME}/.zgen/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/node
    zgen oh-my-zsh plugins/cabal
    zgen oh-my-zsh plugins/npm
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
    #zgen load zsh-users/zsh-completions src

    zgen load jimmijj/zsh-syntax-highlighting

    # autosuggestions should be loaded last
    zgen load tarruda/zsh-autosuggestions . pre-v0.1.0

    # save all to init script
    zgen save
fi

## Enable autosuggestions automatically.
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init
bindkey '^R' autosuggest-execute-suggestion
autoload -U compinit && compinit

export GOPATH=$HOME
export PATH=$PY_DIR:$HOME/.cargo/bin:$HOME/Library/Haskell/bin:$HOME/.local/bin:/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.cabal/bin:$GOPATH/bin:$HOME/bin:$HOME/Dropbox/bin
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
alias gb='./gradlew clean build --info --no-daemon'
export GROOVY_HOME=/usr/local/opt/groovy/libexec

rm -f ~/yankring_history_v2.txt

function setjava() {
    vers=$1
    export JAVA_HOME=`/usr/libexec/java_home -v $vers`
}

setjava '1.8'

function update() {
    echo "$BACKGROUND_RED      Homebrew      $RESET_FORMATTING" &&
    brew update && brew upgrade && brew cleanup
    echo "$BACKGROUND_RED        ZGEN        $RESET_FORMATTING" &&
    zgen update
    ((which aws && echo "$BACKGROUND_RED       AWS-CLI      $RESET_FORMATTING" && sudo pip2 install awscli --upgrade) || true) &&
    echo "$BACKGROUND_RED        VIM         $RESET_FORMATTING" &&
    (vim -c ":PluginUpdate" -c ":q" -c ":q")
    (which update_rust && echo "$BACKGROUND_RED        RUST        $RESET_FORMATTING" && update_rust) &&
    (cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --init --force --recursive && echo updated &&
        cd third_party/ycmd/ && git submodule update --recursive --init --force && \
        cd $HOME/.vim/bundle/YouCompleteMe && ./install.py --racer-completer --go-completer --java-completer)
}
alias brewup='update'

function psrid() {
    psgrep -n $1 | awk '{ print $2 }' | xargs sudo kill -9 {}
}

# Docker
unset DOCKER_TLS_VERIFY
unset DOCKER_HOST
unset DOCKER_CERT_PATH
unset DOCKER_MACHINE_NAME

# for mactex
eval `/usr/libexec/path_helper -s`

if [ -f $HOME/.this_zshrc ] ; then
    source $HOME/.this_zshrc
fi

# NODE VERSION MANAGER
# https://github.com/creationix/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"


export RUSTFLAGS="-C target-cpu=native"
alias flush_dns="sudo killall -HUP mDNSResponder"

source /usr/local/bin/aws_zsh_completer.sh
