#!/bin/bash
source deactivate
_script="$(readlink -f ${BASH_SOURCE[0]})"
_base="$(dirname $_script)"

echo "Script name : $_script"
echo "Current working dir : $PWD"
echo "Script location path (dir) : $_base"

cd $_base
ln -fs /usr/bin/python2 /usr/bin/python
source ~/.venv/python2/bin/activate
git checkout master

python --version
ansible --version

echo "Checking for Underscore origin inventory backups"
if test -f "/etc/ansible/hosts.underscore.bak"; then
    echo "Underscore origin Inventory backup present"
else
    cp /etc/ansible/hosts /etc/ansible/hosts.underscore.bak
    echo "Underscore origin Inventory backup created"
fi
echo "Attempting switching inventory files"
if test -f "/etc/ansible/hosts.hyphen.bak"; then
    echo "Hyphen origin Inventory backup present, restoring"
    cp /etc/ansible/hosts.hyphen.bak /etc/ansible/hosts
else
    echo "Hyphen Inventory backup not present"
fi
