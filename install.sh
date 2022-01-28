#!/bin/bash
BASE_DIR=`dirname "$0"`
BASE_DIR=`cd "$BASE_DIR"; pwd`

install_symlinks() {
  src="$BASE_DIR/$1"
  dst="$HOME/.$1"

  if [ -f $dst ]; then
    echo "remove $dst first"
    rm -rf $dst
  fi
  echo "create symlink $dst -> $src"
  ln -s $src $dst
}

CONFIG_FILES='gitconfig gitignore_global tmux.conf vim vimrc vimrc.bundles zshrc'

for f in $CONFIG_FILES; do
  install_symlinks $f
done

echo "RUN the following command to install the zsh-autosuggestions plugin\n\$ git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
