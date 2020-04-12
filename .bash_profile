

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

}


abbrv_wd() {
    # used to abbreviate the file path (takes a file path)
    
    local FPATH=$(echo $1 | sed 's`'"$HOME"'`~`')
    LENGTH=$(echo $FPATH | sed -E "s/[^\/]//g" | wc -c)
    
    if [[ "$LENGTH" -gt 3 ]]; then
        END=$(echo $FPATH | grep -Eo "[^\/]*\/[^\/]*\/[^\/]*$")
        ABBRV=$( echo $FPATH | sed -E "s/(\/.)[^\/]*/\1/g")
        ABBRV=${ABBRV/%??????/}
        FINAL=${ABBRV}/${END}
        echo $FINAL
    else
        echo $FPATH
    fi
}

export PS1="\u\[\033[0;35m\] \$(abbrv_wd \w)\[\033[32m\]\$(parse_git_branch)\[\033[33m\] ♘\[\033[00m\]  "
export PS2="→ "


PATH=$PATH:/usr/local/bin/; export PATH

 #from https://natelandau.com/my-mac-osx-bash-profile/
export PATH=~/.local/bin:$PATH


alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias ~="cd ~"                              # ~:            Go Home
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
alias c='clear'

ls () { /bin/ls -F $*;  }

alias py3='python3'

# git commands

Gmove-commit-to() { git checkout -b "$1" && git reset HEAD~ --hard && git checkout "$1"; }
alias Gs='git stash'
gac() { git add -A && git commit -am "$1"; }
gbd() { git branch -d "$1"; }
gbD() { git branch -D "$1"; }
alias gmm='git merge master'
alias gm='git checkout master'
alias gp='git pull'
alias gb='git branch'
gcb() { git checkout -b "$1"; }
alias gcE="git commit --allow-empty -m 'automated empty commit'"
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash

alias gpr="gpb $@" # push to the current branch you're in on `origin`

gpb() {
  BRANCH=$(git branch | grep \*|cut -c3-);
  echo "pushing to [$BRANCH]";
  git push origin $BRANCH;
}

alias rm-stale="git fetch --prune && git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }

# ----------------------------------------------------




# git bash completion!
# --------------------
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# clear git credentials
# ------------------------------
# alias git-clear="./responses.txt | git credential-osxkeychain erase"
#alias git-clear="sudo ./responses.txt | ~/swanked-out-bash/.clear-git-credentials.bash"


# Surpress annoying zsh plug on Catalina
export BASH_SILENCE_DEPRECATION_WARNING=1

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
