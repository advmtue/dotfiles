#exec i3
xrdb -l ~/.Xresources
xrdb -merge ~/.xrdb_extra

compton -b
hsetroot -solid "#000000"

while true; do
	dwm_status update
	sleep 5;
done &
dunst &

exec dwm
