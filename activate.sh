#!/bin/bash
source deactivate
_script="$(readlink -f ${BASH_SOURCE[0]})"
_base="$(dirname $_script)"
echo "Current Setup"
python --version
ansible --version
echo "Script name : $_script"
echo "Current working dir : $PWD"
echo "Script location path (dir) : $_base"

cd $_base
ln -fs /usr/bin/python3 /usr/bin/python
source ~/.venv/python3/bin/activate
git checkout master

python --version
ansible --version

if test -f "/etc/ansible/hosts.underscore.bak"; then
    echo "Underscore origin Inventory backup present, switching"
    cp /etc/ansible/hosts.underscore.bak /etc/ansible/hosts
fi
