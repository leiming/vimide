#!/usr/bin/env bash

source $(dirname $0)/config.sh

function backupVim(){
    dayTime=`date +%Y%m%d_%s`
    backupDir=$HOME/backup/vim_config_bk/$dayTime
    if [[ ! -d $backupDir ]]; then
        mkdir -p $backupDir
    fi
    cp -P ~/.vimrc $backupDir
    cp -R ~/.vim   $backupDir
    cp -P ~/.bash_profile $backupDir

    if [[ -r ~/.zshrc ]]; then
        cp -P ~/.zshrc $backupDir
    fi

}

backupVim
echo -e "已将文件备份至" $backupDir
