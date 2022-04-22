#!/bin/bash
source deactivate
_script="$(readlink -f ${BASH_SOURCE[0]})"
_base="$(dirname $_script)"

echo "Script name : $_script"
echo "Current working dir : $PWD"
echo "Script location path (dir) : $_base"

cd $_base
ln -fs /usr/bin/python3 /usr/bin/python
source ~/.venv/python3/bin/activate
git checkout collections

python --version
ansible --version

echo "Checking for Hyphen origin inventory backups"
if test -f "/etc/ansible/hosts.hyphen.bak"; then
    echo "Underscore origin Inventory backup present"
else
    cp /etc/ansible/hosts /etc/ansible/hosts.hyphen.bak
    echo "Underscore origin Inventory backup created"
fi
echo "Attempting switching inventory files"
if test -f "/etc/ansible/hosts.underscore.bak"; then
    echo "Underscore origin Inventory backup present, switching"
    cp /etc/ansible/hosts.underscore.bak /etc/ansible/hosts
else
    echo "Underscore Inventory backup not present"
    cat /etc/ansible/hosts | sed 's/^\(\[.*\)-/\1_/g' | sed 's/^\(.*\)-/\1_/g' > /etc/ansible/hosts.underscore.bak
    cp /etc/ansible/hosts.underscore.bak /etc/ansible/hosts
    echo "Underscore origin Inventory created and switched"
fi
