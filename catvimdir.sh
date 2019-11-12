#!/usr/bin/env bash

source $(dirname $0)/config.sh
BASEDIR=$(cd $(dirname $BASH_SOURCE);pwd)

if [[ -h ~/.vim ]]; then
    rm -rf ~/.vim
fi

if [[ ! -d ~/.vim ]]; then
    mkdir -p ~/.vim/
fi

if [[ ! -r "$TEAM_BUNDLE_DIR" ]]; then
    echo -e "---- 正在创建 $TEAM_BUNDLE_DIR , 请输入sudo 权限密码： ----\n"
    sudo mkdir -p $TEAM_BUNDLE_DIR
    sudo chmod 777 $TEAM_BUNDLE_DIR
fi

if [[ ! ~/.vim/team_bundle -ef "$TEAM_BUNDLE_DIR" ]]; then
    echo -e "---- 更新 ~/.vim/team_bundle ----\n"
    rm -rf ~/.vim/team_bundle
    ln -s $TEAM_BUNDLE_DIR ~/.vim/team_bundle
fi

if [[ ! -r  ~/.vim/autoload/plug.vim ]]; then
    echo -e "---- 更新 ~/.vim/autoload/plug.vim ----\n"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Remove pylon_ide due to being changed repo.

if [[ ! -r ~/.editorconfig ]]; then
    echo -e "---- 生成 ~/.vim/.editorconfig 文件 ----\n"
    cp -f $BASEDIR/.editorconfig  ~/
fi
