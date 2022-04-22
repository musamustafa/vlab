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
ln -fs /usr/bin/python2 /usr/bin/python
source ~/.venv/python2/bin/activate

python --version
ansible --version

if test -f "/etc/ansible/hosts.hyphen.bak"; then
    echo "hyphen origin Inventory backup present, switching"
    cp -f /etc/ansible/hosts.hyphen.bak /etc/ansible/hosts
fi
