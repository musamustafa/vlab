#!/bin/bash
declare -A distromap;
distromap[/etc/redhat-release]=yum
distromap[/etc/arch-release]=pacman
distromap[/etc/gentoo-release]=emerge
distromap[/etc/SuSE-release]=zypp
distromap[/etc/debian_version]=apt-get

for f in ${!distromap[@]}
do
    if [[ -f $f ]];then
        package_manager=${distromap[$f]}
    fi
done
if [[ "$package_manager" == "apt-get" ]];then
  $package_manager update
  $package_manager upgrade -y
  $package_manager install build-essential checkinstall -y
  $package_manager install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y
elif [[ "$package_manager" == "yum" ]];then
  $package_manager -y groupinstall "Development Tools"
  $package_manager -y install gcc openssl-devel bzip2-devel libffi-devel
fi
