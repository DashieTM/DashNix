find $PWD -maxdepth 1 -mindepth 0 -exec ln -s '{}' $HOME/.config/ \;
mv $HOME/.config/.zshrc ../.zshrc
unlink $HOME/.config/.git
unlink $HOME/.config/.gitignore
unlink $HOME/.config/README.md
unlink $HOME/.config/setup.sh
unlink $HOME/.config/dotFiles

sudo pacman -S rustup
rustup default nightly
cargo install paru
pac load

gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' && gsettings set org.gnome.desktop.interface color-scheme 'default'

cargo install oxinoti
cargo install oxidash
cargo install oxishut
cargo install hyprdock
cargo install reset

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

reboot
