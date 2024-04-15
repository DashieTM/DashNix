find $PWD -maxdepth 1 -mindepth 0 -exec ln -s '{}' $HOME/.config/ \;
unlink $HOME/.config/.git
unlink $HOME/.config/.gitignore
unlink $HOME/.config/README.md
unlink $HOME/.config/setup.sh
unlink $HOME/.config/copy_dotfiles.sh
unlink $HOME/.config/dotFiles

