#!/bin/bash
#####################################banner

echo -e "  \n This script will replace all the existing Playbooks on your repository with newer Playbooks.

The files/directories that will get affected: 
ensure-kvm-running.yml, ansible.cfg, get-config-from-device.yml, install-config-to-device.yml, push-directory-to-git.yml, config_cleanup.py, get-encrypted-password.py, install-vxlan-linux-host.yml, README.md,docs, group_vars, library, roles, renew-serial-id-vMX_NV.yaml

   *Any custom configuration on those files on your repository will be affected* \n"

sleep 5 
##################################### vars
ansible_playbook_path=/root/JCL_Ansible_Playbooks
default_path=/root/clonesrepo
git_path_jcl="--git-dir=$ansible_playbook_path/.git --work-tree=$ansible_playbook_path"

##################################### user_input for repository list
repo_array=()
echo "Enter the repository names: (Press ctrl+D at the end of the list)"

while read repo
do
    repo_array+=($repo)
done
#echo "Repository List : ${repo_array[@]}"
echo ""

##################################### storing all repos in one place
mkdir $default_path
cd $default_path

##################################### git clone respos
for clones in "${repo_array[@]}"; do
   git clone $clones
   echo -e "\n$clones\n"
done

###################################### file check conditions
compare_file=$ansible_playbook_path/get_config_from_device.yml

if test -f "$compare_file"; then
echo -e "\nproceeding with update "
else
    echo "activing virtual environment"
    git $git_path_jcl checkout collections
fi

######################################## copy and remove files
for repo_path in  "$default_path"/*; do 
   rm -rf $repo_path/{ensure-kvm-running.yml,ansible.cfg,get-config-from-device.yml,install-config-to-device.yml,push-directory-to-git.yml,config_cleanup.py,get-encrypted-password.py,install-vxlan-linux-host.yml,README.md,docs,group_vars,library,roles,renew-serial-id-vMX_NV.yaml}

   cp -rf $ansible_playbook_path/{activate.sh,ensure_kvm_running.yml,install_vxlan_linux_host.yml,README.md,switch.sh,ansible.cfg,get_config_from_device.yml,push_directory_to_git.yml,requirements.txt,upgrade_junos.yml,banner_test.yml,group_vars,python_scripts,roles,docs,install_config_to_device.yml,python_version_check.yml,shell_scripts} $repo_path
   echo "$repo_path"
   echo -e "\nEnter "yes" if you want to push changes to git $repo_path: "

######################################### git push 
   read user_input
   if [ $user_input == "yes" ]
   then
      git_path="--git-dir=$repo_path/.git --work-tree=$repo_path"
      git $git_path add --all
      git $git_path commit -m "new ansible playbooks"
      git $git_path push
      echo -e "\ngit push SUCCESSFUL\n"
      rm -rf $repo_path
   else
      echo -e "\ngit push ABORTED"  
      echo -e "\nIf you wish to push the changes yourselves on this repository,find it under $repo_path"
   fi
done
echo -e "\nAny custom files on your repository will not be modified. Users need to upgrade those scripts/files to suppot newer version of Ansible & Python"

    