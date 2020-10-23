#exec i3
xrdb -l ~/.Xresources
xrdb -merge ~/.xrdb_extra

picom -b
hsetroot -solid "#000000"
dunst &

export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=nvidia

exec i3
