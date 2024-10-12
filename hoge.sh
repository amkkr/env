if [[ -d $HOME/.config ]] then
  ln -s `pwd`/warp-terminal ~/.config/
else
  mkdir -p $HOME/.config
  ln -s `pwd`/warp-terminal ~/.config/
fi
