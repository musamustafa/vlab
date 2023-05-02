#!/bin/bash
#####################################banner

echo -e "\nThis script will replace all existing JCL_Ansible_Playbooks in your specified repos, with the latest Python3 version of JCL_Ansible_Playbooks.

The files/directories that will get affected: 
ensure-kvm-running.yml, ansible.cfg, get-config-from-device.yml, install-config-to-device.yml, push-directory-to-git.yml,
config_cleanup.py, get-encrypted-password.py, install-vxlan-linux-host.yml, README.md,docs,
group_vars, library, roles, renew-serial-id-vMX_NV.yaml

   **Any custom modifications in the above file/directories in your repository will be lost!** \n"

sleep 5 
##################################### vars
ansible_playbook_path=/root/JCL_Ansible_Playbooks
default_path=/root/clonesrepo
git_path_jcl="--git-dir=$ansible_playbook_path/.git --work-tree=$ansible_playbook_path"

##################################### user_input for repository list
repo_array=()
echo "Enter the repo clone URLs (SSH or HTTPS) for the repos that you want to update:
(Press ctrl+D at the end of the list)\n"

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
   echo -e "\n\nClone location: $default_path"
   echo -e "\nAttempting to clone $clones.."
   git clone $clones
done

###################################### file check conditions
compare_file=$ansible_playbook_path/get_config_from_device.yml

if test -f "$compare_file"; then
echo -e "Found latest Python3 version of JCL_Ansible_Playbooks. Proceeding with update.."
else
    echo "Getting latest Python3 version of JCL_Ansible_Playbooks.."
    git $git_path_jcl checkout collections
fi

######################################## copy and remove files
for repo_path in  "$default_path"/*; do 
   rm -rf $repo_path/{ensure-kvm-running.yml,ansible.cfg,get-config-from-device.yml,install-config-to-device.yml,push-directory-to-git.yml,config_cleanup.py,get-encrypted-password.py,install-vxlan-linux-host.yml,README.md,docs,group_vars,library,roles,renew-serial-id-vMX_NV.yaml}

   cp -rf $ansible_playbook_path/{activate.sh,ensure_kvm_running.yml,install_vxlan_linux_host.yml,README.md,switch.sh,ansible.cfg,get_config_from_device.yml,push_directory_to_git.yml,requirements.txt,upgrade_junos.yml,group_vars,python_scripts,roles,docs,install_config_to_device.yml,python_version_check.yml,shell_scripts} $repo_path

   echo -e "\nCompleted updating local repo *for $repo_path."
   echo -e "\nEnter "yes" if you want to push updates to Git *for $repo_path: "

######################################### git push 
   read user_input
   if [ $user_input == "yes" ]
   then
      git_path="--git-dir=$repo_path/.git --work-tree=$repo_path"
      git $git_path add --all
      git $git_path commit -m "Updated Ansible playbooks from latest Python3 version of JCL_Ansible_Playbooks using update_repositories.sh"
      git $git_path push
      echo -e "\nGit commit and push SUCCESSFUL *for $repo_path."
      rm -rf $repo_path
   else
      echo -e "\nGit push ABORTED *for $repo_path !"  
      echo -e "\nIf you want to commit and push changes to this repo yourself, find the updated repo at $repo_path."
   fi
done
echo -e "\nAny custom files in your repo will *not* be updated. You would need to manually update those files to support the latest versions of Ansible & Python(3)."

    
