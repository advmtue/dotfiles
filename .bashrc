#   If not running interactively, don't do anything
[[ $- != *i* ]] && return

#   Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l'
alias mkt='cd $(mktemp -d)'
alias music="ncmpcpp"
alias feh="feh -g 900x700"

#   Check the window size after each command
shopt -s checkwinsize

#   Use nvim as editor
export VISUAL=nvim
export EDITOR="$VISUAL"

#   Default File Permissions
#   u=rwx,g=,o=
umask 077

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
    if [ "$HOSTNAME" != "box" ]; then
        echo "$(saf 11)@$HOSTNAME"
    fi
}

#   Potential Exports
p_c="$(saf 1)\u$(shost) $(saf 7)\w $(res)$ "
p_nc="\u@\h \w $ "

#   Export depending on TERM
case "$TERM" in
    *-256color) export PS1=$p_c;;
    *) export PS1=$p_nc;;
esac

#   Clear local functions
unset -f saf
unset -f res


case "$TERM" in
xterm*|rxvt*|screen*)
    PROMPT_COMMAND='echo -ne "\033]0;[${USER}@${HOSTNAME}] $(dirs)\007"'

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;[${USER}@${HOSTNAME}] $(dirs) \$ ${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac
