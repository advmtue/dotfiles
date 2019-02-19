#exec i3
xrdb -l ~/.Xresources
compton -b
hsetroot -solid "#000000"
dunst &

while true; do
	dwm_status update
	sleep 5;
done &

exec dwm
