find $PWD -maxdepth 10 -mindepth 1 -type d -exec ln -s '{}' $HOME/.config/ \;
