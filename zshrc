ZSH=$HOME/.oh-my-zsh
plugins=(git node cabal npm git-extras github git-flow mvn brew osx nvm scala docker sbt aws gradle)

fpath=(~/.zsh/completion $fpath)

source $ZSH/oh-my-zsh.sh
source $(brew --prefix nvm)/nvm.sh

#local OPENSSLVERS=`ls /usr/local/Cellar/openssl/ | head -n 1`
#export PKG_CONFIG_PATH=/usr/local/Cellar/openssl/$OPENSSLVERS/lib/pkgconfig
#alias openssl=/usr/local/Cellar/openssl/`ls /usr/local/Cellar/openssl/ | head -n 1`/bin/openssl
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
alias gw='./gradlew'

rm -f ~/yankring_history_v2.txt

function setjava() {
    vers=$1
    export JAVA_HOME=`/usr/libexec/java_home -v $vers`
}
setjava 1.7


function brewup() {
    brew update && brew upgrade --all && brew cleanup
}

function psrid() {
    psgrep -n $1 | awk '{ print $2 }' | xargs sudo kill -9 {}
}

function eclimd() {
    psrid eclimd 2> /dev/null
    nohup /Applications/eclipse/eclimd &
}

$(boot2docker shellinit 2> /dev/null)
export DOCKER_TLS_VERIFY=0

# for mactex
eval `/usr/libexec/path_helper -s`

export GROOVY_HOME=/usr/local/opt/groovy/libexec

# oracle
source /usr/local/share/instantclient/instantclient.sh
alias sqlplus='rlwrap sqlplus'
