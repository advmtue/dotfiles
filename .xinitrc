#exec i3
xrdb -l ~/.Xresources
xrdb -merge ~/.xrdb_extra

picom -b
hsetroot -solid "#000000"
dunst &

xrandr --output DP-0 --mode 2560x1440 --rate 144

export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=nvidia

exec i3
