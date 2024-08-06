source ~/.zsh_plugs/funcs.zsh 
sxhkd &
#autorandr --change primary &
dunst &
picom &
flameshot &
polybar-themes/simple/launch.sh --hack &
# network manager applet
nm-applet &

#sound breh
if [[ ! `pidof pipewire` ]]; then
	gentoo-pipewire-launcher &
fi


# wallpaper
lxsession &
# policy kit
if [[ ! `pidof xfce-polkit` ]]; then
	/usr/libexec/xfce-polkit &
fi

#hide borders of inactive windows
if ["$(ps aux | grep -o ".config/bspwm/hideborder.sh")" != ""]
then
	echo "RUN"
else
	sh .config/bspwm/hideborder.sh &
fi
