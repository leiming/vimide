#!/usr/bin/env bash

# BASEDIR=$(dirname $0)
BASEDIR=$(cd $(dirname $BASH_SOURCE);pwd)
source $BASEDIR/config.sh

if [[ "$1" = "-h" ]]; then
    echo ""
    echo -e "--     当前VJ版本: $VJ_VERSION\n"
    echo -e "-f     Force   强行更新.vimrc脚本为最新版"
    echo -e "-h     Help    显示此帮助信息并退出"
    echo ""
    exit 0
fi

echo -e "---- 备份VJ ----\n"
bash $BASEDIR/backup.sh

echo -e "---- 更新.vimrc ----\n"
if [[ "$1" = "-f" ]]; then
    bash $BASEDIR/catvimrc.sh -f
else
    bash $BASEDIR/catvimrc.sh
fi


if [[ ! -r ~/.jsbeautifyrc  ]]; then
    echo -e "---- 更新.jsbeautifyrc ----\n"
    cp $BASEDIR/.jsbeautifyrc ~/
fi

echo -e "---- 更新.vim ----\n"
bash $BASEDIR/catvimdir.sh

if [[ -e ~/.bash_profile ]]; then
    echo -e "---- 更新.bash_profile ----\n"
    sed -i -e '/_vj_bashrc/d' ~/.bash_profile
    sed -i -e '/alias[ ]*vj/d' ~/.bash_profile

    echo -e "alias vjbackup=\"bash $BASEDIR/backup.sh\""      >> ~/.bash_profile
    echo -e "alias vjrecovery=\"bash $BASEDIR/recovery.sh\""  >> ~/.bash_profile
    echo -e "alias vjupdate=\"bash $BASEDIR/update.sh\""      >> ~/.bash_profile
    echo -e "alias vj=\"vim '+call VjOpen()'\""               >> ~/.bash_profile
    echo -e "source $BASEDIR/_vj_bashrc"                      >> ~/.bash_profile
fi

if [[ -e ~/.zshrc ]]; then
    echo -e "---- 更新.zshrc ----\n"
    sed -i -e '/_vj_bashrc/d' ~/.zshrc
    sed -i -e '/alias[ ]*vj/d' ~/.zshrc

    echo -e "alias vjbackup=\"bash $BASEDIR/backup.sh\""      >> ~/.zshrc
    echo -e "alias vjrecovery=\"bash $BASEDIR/recovery.sh\""  >> ~/.zshrc
    echo -e "alias vjupdate=\"bash $BASEDIR/update.sh\""      >> ~/.zshrc
    echo -e "alias vj=\"vim '+call VjOpen()'\""               >> ~/.zshrc
    echo -e "source $BASEDIR/_vj_bashrc"                      >> ~/.zshrc
fi


read -p "VJ已经更新完成，请问需要立即生效吗？（否则将在下次登录时生效）[ctrl+c]取消(y/n) y:" isSource
case $isSource in
    y | Y | yes | YES | "")  source ~/.bash_profile
esac

