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
echo -e $'Enter the repo clone URLs (SSH or HTTPS) for the repos that you want to update:
(Press Enter, then, Ctrl+D at the end of the list)\n'

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
   echo -e "Attempting to clone $clones.."
   git clone $clones
done

###################################### file check conditions
compare_file=$ansible_playbook_path/get_config_from_device.yml

if test -f "$compare_file"; then
echo -e "\nFound latest Python3 version of JCL_Ansible_Playbooks. Proceeding with update.."
else
    echo "\nGetting latest Python3 version of JCL_Ansible_Playbooks.."
    git $git_path_jcl checkout collections
fi

######################################## copy and remove files
for repo_path in  "$default_path"/*; do 
   rm -rf $repo_path/{ensure-kvm-running.yml,get-config-from-device.yml,install-config-to-device.yml,install-vxlan-linux-host.yml,push-directory-to-git.yml,renew-serial-id-vMX_NV.yaml,config_cleanup.py,get-encry
pted-password.py,docs,group_vars,library,roles,README.md}

   #cp -rf $ansible_playbook_path/{ensure_kvm_running.yml,get_config_from_device.yml,install_config_to_device.yml,install_vxlan_linux_host.yml,push_directory_to_git.yml,python_version_check.yml,upgrade_junos.yml
,docs,group_vars,python_scripts,roles,shell_scripts,README.md} $repo_path

   echo -e "\n**** For $repo_path: ****"
   echo -e "\nRemoved Python2 supported files. Creating local commit Step 1/2.."
   git_path="--git-dir=$repo_path/.git --work-tree=$repo_path"
   git $git_path add --all
   git $git_path commit -m "Updated Ansible playbooks using update_repositories.sh - Step 1: Removed Python2 supported files from repo."

   git $git_path remote add JCL "https://git.cloudlabs.juniper.net/JCL/JCL_Ansible_Playbooks.git"
   git $git_path fetch JCL
   git $git_path merge JCL/collections -m "Merging latest Python3 updates from JCL_Ansible_Playbooks official: collections branch"
   git $git_path ls-tree --name-only JCL/collections | while read file; do if [ ! -f "$file" ]; then git $git_path checkout JCL/collections -- "$file"; echo -e "$file"; fi; 
done;
   rm -rf $repo_path/motd
   echo -e "Added/updated Python3 supported files. Creating local commit Step 2/2.."
   git $git_path add .
   git $git_path commit -m "Updated Ansible playbooks using update_repositories.sh - Step 2: Added/updated Python3 supported files to repo."
   echo -e "\nGit local commits SUCCESSFUL for $repo_path."

   echo -e "\nEnter 'yes' if you want to push updates (now) to Git for $repo_path: "
######################################### git push 
   read user_input
   if [ $user_input == "yes" ]
   then
      git $git_path push
      if [ $? -eq 0 ]; then
         echo -e "\nGit push SUCCESSFUL for $repo_path"
         echo -e "Deleting $repo_path"
         rm -rf $repo_path
      else
         echo -e "\nGit push FAILED for $repo_path"
         echo -e "Please MANUALLY resolve conflicts and push to Git. You can find the updated repo at $repo_path"
      fi
   else
      echo -e "\nGit push ABORTED for $repo_path !"  
      echo -e "If you want to push changes to this repo yourself, find the updated repo at $repo_path"
   fi
done
echo -e "\nAny custom files in your repo will *not* be updated. You would need to manually update those files to support the latest versions of Ansible & Python(3)."
