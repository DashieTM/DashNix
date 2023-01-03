find $PWD -maxdepth 10 -mindepth 1 -type d -exec ln -s '{}' $HOME/.config/ \;
mv $HOME/.config/.zshrc ../.zshrc
unlink $HOME/.config/.git 
unlink $HOME/.config/.gitignore
unlink $HOME/.config/README.md
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
