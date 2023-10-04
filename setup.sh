find $PWD -maxdepth 1 -mindepth 0 -exec ln -s '{}' $HOME/.config/ \;
mv $HOME/.config/.zshrc ../.zshrc
unlink $HOME/.config/.git
unlink $HOME/.config/.gitignore
unlink $HOME/.config/README.md
unlink $HOME/.config/hypr_desktop
unlink $HOME/.config/hypr_laptop
unlink $HOME/.config/setup.sh
unlink $HOME/.config/dotFiles

gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' && gsettings set org.gnome.desktop.interface color-scheme 'default'

if [ "$1" = "laptop" ]; then
	ln -s $PWD/hypr_laptop $HOME/.config/hypr
elif [ "$1" = "desktop" ]; then
	ln -s $PWD/hypr_desktop $HOME/.config/hypr
fi
