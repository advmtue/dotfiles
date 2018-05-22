# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l'
alias music="ncmpcpp"
alias feh="feh -g 900x700"

# Check the window size after each command
shopt -s checkwinsize

# Use nvim as editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# -- Colors
# General Color Format:
#   \[\033[(dark|light);(code)m\]
#
# Dark / Light codes:
#   0 = dark
#   1 = light
#
# Colors codes
#   30 = black    Light = Dark Gray
#   31 = red
#   32 = green
#   33 = brown
#   34 = blue
#   35 = purple
#   36 = cyan
#   37 = gray     Light = White

# Default color
color_reset="\[\033[0;0m\]"

# Function: color_set
#   Concatenator func
#   Returns color string
function color_set {
    echo "\[\033[$1;$2m\]"
}

# Potential Exports
ps1_color="$(color_set 0 31)\u$color_reset \w $ "
ps1_nocolor="\u@\h \w $ "

# Export depending on TERM
case "$TERM" in
    *-256color) export PS1=$ps1_color;;
    *) export PS1=$ps1_nocolor;;
esac
