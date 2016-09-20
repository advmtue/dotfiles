#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# A few aliases for good measure
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lh'
alias lal='ls -Alh'
alias lc='ls --format single-column'
alias music="ncmpcpp"

# Check the window size after each command
shopt -s checkwinsize

#################################################
# PS1 Colors and Config
c_pref="\[\033["
c_suff="m\]"
c_dark="0"
c_light="1"
c_res=$c_pref"0;0"$c_suff

c_black="30"    # Light = Dark Gray
c_red="31"
c_green="32"
c_brown="33"
c_blue="34"
c_purple="35"
c_cyan="36"
c_gray="37"     # Light = White

# function c_s: set color
function c_s {
    echo "$c_pref$1;$2$c_suff"
}

ps1_color="[$(c_s $c_dark $c_red)\u$c_res \w] $"
ps1_nocolor="\u@\h \w $"

# Only color if we have the right support
case "$TERM" in
    rxvt-unicode-256color) export PS1=$ps1_color;;
    *) export PS1=$ps1_nocolor;;
esac
