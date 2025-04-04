#   If not running interactively, don't do anything
[[ $- != *i* ]] && return

#   Aliases
alias ls='ls -G'
alias musb="sudo mount -o uid=`whoami`,gid=`whoami`,fmask=113,dmask=002"
alias tasks='git grep -EIn "TODO|FIXME"'

#   CD Burning
alias cdw_dummy='cdrecord -dummy -v speed=1 -dao -audio *.wav'
alias cdw='cdrecord -v speed=1 -dao -audio *.wav'
alias cdw_wav='for i in *.mp3; do lame --decode "$i" "$(basename "$i" .mp3)".wav; done'

#   Check the window size after each command
#shopt -s checkwinsize

# FZF use hidden files
export FZF_DEFAULT_COMMAND="rg --files -L --hidden"

#   Use vim as editor
alias vim='nvim'
export VISUAL=nvim
export EDITOR="$VISUAL"

#   Default File Permissions
#   u=rwx,g=rwx,o=r
umask 0002

#   No bash_history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
#bindkey -v
bindkey '^R' history-incremental-search-backward

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

#   Set the terminal color to a given value
function setcolor {
    echo "$(tput setaf $1)"
}

#   Reset the terminal color
function res {
    echo "$(tput sgr0)"
}

#   Get a hostname string.
#   Returns the hostname if the TTY is a SSH connection
function shost {
    if [ -z "$SSH_CONNECTION" ]; then
        echo "";
    else
        echo "@%m"
    fi
}

#   Coloured prompt
p_c="%{$(setcolor 0)%}[%n]$(shost) %~ %{$(res)%}%# "
#   Uncoloured prompt
p_nc="[%n]$(shost) %~ %# "
p_basic="%~ %# "

#   Export depending on TERM
case "$TERM" in
    *-256color) export PS1=$p_basic;;
    *) export PS1=$p_basic;;
esac

#   Clear local functions
unset -f setcolor res shost

#   Execute any supplementary files
if [ -f "$HOME/.shell_extras" ]; then
    source "$HOME/.shell_extras"
fi


