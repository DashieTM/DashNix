./copy_dotfiles.sh
sudo pacman -S rustup --noconfirm
rustup default nightly
cargo install paru
pac load

gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' && gsettings set org.gnome.desktop.interface color-scheme 'default'
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Classic'
gsettings set org.gnome.desktop.interface cursor-size 24 

cargo install oxinoti
cargo install oxidash
cargo install oxishut
cargo install hyprdock
