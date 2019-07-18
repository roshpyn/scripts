#!/bin/bash
version="19.07.15v1"
author="roshpyn"
function Get-Help {
echo "$0 v$version

by $author"
}
source ./Draw-ProgressBar.sh 

toinstall=(
    Update
    Upgrade
    Get-neovim
    Get-dwm
    Get-Rust
    Get-go
    Get-Code
    Auto
    #Install-dwm
)
echo ${toinstall[*]}
function Is-Parameter {
    # $1 - argument   S2, $3 - expected parameters 
    if [ $1 == $2 -o $1 == $3 ]; 
    then 
        true
    else 
        false
    fi
}
Update () { apt -qq -q update ; }
Upgrade () { apt -qq -q upgrade -y ; }
Auto () { 
    apt -qq -q autoremove 
    apt -qq -q autoclean 
}

Get-neovim () {
    apt -qq -q install python-dev python-pip python3-dev python3-pip -y
    pip3 install --user pynvim 
    echo | add-apt-repository ppa:neovim-ppa/stable 
    apt -qq -q update
    apt -qq -q install neovim 
}
Get-dwm () {
    mkdir ~/srcs 
    cd ~/srcs 
    git clone git://git.suckless.org/dwm &>/dev/null
}
Get-go () {
    apt -qq -q install golang -y
}
Get-Rust () {
    apt -qq -q install cargo -y 
}
Get-Code () {
    snap install code --classic 2>/dev/null
}

function Install {
    Get-ProgressBar ${toinstall[*]}
}

arg=$1

if Is-Parameter $arg "-h" "--help"; then
    Get-Help
elif Is-Parameter $arg "-i" "--install"; then
    Install
fi