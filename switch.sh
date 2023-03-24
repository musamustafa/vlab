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

echo "Switching host inventory names - replacing Underscores with Hyphens.."
if test -f "/etc/ansible/hosts.underscore.bak"; then
    echo "Underscore host inventory backup present."
else
    cp /etc/ansible/hosts /etc/ansible/hosts.underscore.bak
    echo "Underscore host inventory backup created."
fi
if test -f "/etc/ansible/hosts.hyphen.bak"; then
    cp /etc/ansible/hosts.hyphen.bak /etc/ansible/hosts
    echo "Original Hyphen host inventory backup present. Switch success."
else
    echo "Original Hyphen host inventory backup not present."
fi
