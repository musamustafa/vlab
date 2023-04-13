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

cd $PWD
python --version
ansible --version
