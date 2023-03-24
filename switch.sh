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

echo "Switching host inventory names - replacing Hyphens with Underscores.."
if test -f "/etc/ansible/hosts.hyphen.bak"; then
    echo "Hyphen host inventory backup present."
else
    \cp /etc/ansible/hosts /etc/ansible/hosts.hyphen.bak
    echo "Hyphen host inventory backup created."
fi
if test -f "/etc/ansible/hosts.underscore.bak"; then
    cp /etc/ansible/hosts.underscore.bak /etc/ansible/hosts
    echo "Underscore host inventory backup present. Switch success."
else
    echo "Underscore host inventory backup not present."
    cat /etc/ansible/hosts | sed 's/^\(\[.*\)-/\1_/g' | sed 's/^\(.*\)-/\1_/g' > /etc/ansible/hosts.underscore.bak
    cp /etc/ansible/hosts.underscore.bak /etc/ansible/hosts
    echo "Underscore host inventory created. Switch success."
fi

if [[ -f "/etc/ansible/group_vars/all/vxlannv.yaml" ]]; then
    # echo "Switching vxlan inventory names - replacing Hyphens with Underscores.."
    if test -f "/etc/ansible/group_vars/all/vxlannv.hyphen.bak.yaml"; then
        : # echo "Hyphen vxlan inventory backup present."
    else
        \cp /etc/ansible/group_vars/all/vxlannv.yaml /etc/ansible/group_vars/all/vxlannv.hyphen.bak.yaml
        # echo "Hyphen vxlan inventory backup created."
    fi
    if test -f "/etc/ansible/group_vars/all/vxlannv.underscore.bak.yaml"; then
        \cp /etc/ansible/group_vars/all/vxlannv.underscore.bak.yaml /etc/ansible/group_vars/all/vxlannv.yaml
        # echo "Underscore vxlan inventory backup present. Switch success."
    else
        # echo "Underscore vxlan inventory backup not present."
        cat /etc/ansible/group_vars/all/vxlannv.yaml | sed 's/^\(\[.*\)-/\1_/g' | sed 's/^\(.*\)-/\1_/g' > /etc/ansible/group_vars/all/vxlannv.underscore.bak.yaml
        \cp /etc/ansible/group_vars/all/vxlannv.underscore.bak.yaml /etc/ansible/group_vars/all/vxlannv.yaml
        # echo "Underscore vxlan inventory created. Switch success."
    fi
fi
