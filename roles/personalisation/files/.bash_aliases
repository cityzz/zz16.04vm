# Aliases for multiple directories up
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

alias klean="rm -f *~"

# Some generic tools
alias tmux="tmux -2"
alias ipy="ptipython --vi"

alias despace="find -name '* *' -type f | rename 's/ /_/g'"

alias ws="wavesurfer"
alias wwscor="wavesurfer -config wscor"
alias wlab="wavesurfer -config lab"

function wcl() {
    ls "$@" | wc -l
}

function msga() {
    target=$1
    text=$2
    for term in `who | grep $target | awk '{print $2}'`; do
        if [ $# -eq 3 ]; then
            cowsay -f $3 $text | write $target $term;
        else
            cowsay $text | write $target $term;
        fi
    done;
}

function msg() {
    target=$1
    text=$2
    if [ $# -eq 3 ]; then
        echo cowsay -f $3 $text | write $target;
    else
        echo cowsay $text | write $target;
    fi
}
