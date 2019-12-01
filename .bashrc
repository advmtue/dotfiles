#   If not running interactively, don't do anything
[[ $- != *i* ]] && return

#   Aliases
alias ls='ls --color=auto --group-directories-first'
alias mkt='cd $(mktemp -d)'
alias musb="sudo mount -o gid=users,fmask=113,dmask=002"

#   CD Burning
alias cdw_dummy='cdrecord -dummy -v speed=1 -dao -audio *.wav'
alias cdw='cdrecord -v speed=1 -dao -audio *.wav'
alias cdw_wav='for i in *.mp3; do lame --decode "$i" "$(basename "$i" .mp3)".wav; done'

#   Check the window size after each command
shopt -s checkwinsize

#   Use vim as editor
export VISUAL=vim
export EDITOR="$VISUAL"

#   Default File Permissions
#   u=rwx,g=rwx,o=r
umask 0002

#   No bash_history
unset HISTFILE

#   Colour code reference
#   NAME     DARK   LIGHT
#   Black    0      8
#   Red      1      9
#   Green    2      10
#   Brown    3      11
#   Blue     4      12
#   Purple   5      13
#   Cyan     6      14
#   Gray     7      15

#   Return ANSI color (re: above)
function saf {
    echo "\[$(tput setaf $1)\]"
}

#   Return ANSI Reset
function res {
    echo "\[$(tput sgr0)\]"
}

function shost {
    if [ "$HOSTNAME" != "groundhog" ]; then
        echo "$(saf 11)@$HOSTNAME"
    fi
}

#   Potential Exports
p_c="$(saf 1)\u$(shost) $(saf 7)\w $(res)\\$ "
p_nc="\u@\h \w \\$ "

#   Export depending on TERM
case "$TERM" in
    *-256color) export PS1=$p_c;;
    *) export PS1=$p_nc;;
esac

#   Clear local functions
unset -f saf
unset -f res
unset -f shost

#   Execute any supplementary files
if [ -f "$HOME/.bash_extras" ]; then
    source "$HOME/.bash_extras"
fi
