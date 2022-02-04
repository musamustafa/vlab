#!/bin/sh
cd
[[ -z "$1" ]] && version=$1 || version=3.9.6
prefix_folder=/usr
wget https://www.python.org/ftp/python/$version/Python-$version.tgz
tar -xvf Python-$version.tgz
cd Python-$version
mkdir -p $prefix_folder/python-$version
./configure --prefix=$prefix_folder
make
make altinstall
rm -rf $prefix_folder/P*
