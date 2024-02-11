./copy_dotfiles.sh
sudo pacman -S rustup --noconfirm
rustup default nightly
cargo install paru
pac load

gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' && gsettings set org.gnome.desktop.interface color-scheme 'default'

cargo install oxinoti
sudo cp ~/.carbo/bin/oxinoti /usr/bin/.
cargo install oxidash
sudo cp ~/.carbo/bin/oxidash /usr/bin/.
cargo install oxishut
sudo cp ~/.carbo/bin/oxishut /usr/bin/.
cargo install hyprdock
sudo cp ~/.carbo/bin/hyprdock /usr/bin/.
cargo install ironbar
sudo cp ~/.carbo/bin/ironbar /usr/bin/.
cargo install reset
sudo cp ~/.carbo/bin/reset /usr/bin/.
cargo install rm-improved
sudo cp ~/.carbo/bin/rip /usr/bin/.
cargo install typstfmt
sudo cp ~/.carbo/bin/typstfmt /usr/bin/.
cargo install satty
sudo cp ~/.carbo/bin/satty /usr/bin/.

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

git clone https://github.com/Kirottu/anyrun.git
cd anyrun
cargo build --release
cargo install --path anyrun/
mkdir -p ~/.config/anyrun/plugins
cp target/release/*.so ~/.config/anyrun/plugins
cp examples/config.ron ~/.config/anyrun/config.ron
sudo cp ~/.carbo/bin/anyrun /usr/bin/.

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5

sudo systemctl enable greetd

reboot
