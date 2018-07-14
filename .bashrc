#   If not running interactively, don't do anything
[[ $- != *i* ]] && return

#   Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l'
alias lla='ls -la'
alias mkt='cd $(mktemp -d)'
alias music="ncmpcpp"
alias feh='feh -g 900x700'
alias msfconsole="msfconsole --quiet -x \"db_connect ${USER}@msf\""
alias musb="sudo mount -o gid=users,fmask=113,dmask=002"

alias cdw_dummy='cdrecord -dummy -v -pad speed=1 dev=/dev/sr0 -dao -swab *.wav'
alias cdw='cdrecord -v -pad speed=1 dev=/dev/sr0 -dao -swab *.wav'
alias cdw_wav='for i in *.mp3; do lame --decode "$i" "$(basename "$i" .mp3)".wav; done'

#   Check the window size after each command
shopt -s checkwinsize

#   Use nvim as editor
export VISUAL=nvim
export EDITOR="$VISUAL"

#   Default File Permissions
#   u=rwx,g=,o=
umask 0022

#   No bash_history
unset HISTFILE

#   Colors
#   0   = black
#   1   = red
#   2   = green
#   3   = brown
#   4   = blue
#   5   = purple
#   6   = cyan
#   7   = gray
#   8   = dark gray
#   9   = light red
#   10  = light green
#   11  = light brown
#   12  = light blue
#   13  = light purple
#   14  = light cyan
#   15  = white

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

#   Execute any supplementary files
if [ -f "$HOME/.bash_extras" ]; then
    source "$HOME/.bash_extras"
fi
