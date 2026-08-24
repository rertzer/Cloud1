#!/bin/sh

sql_pass=`head /dev/random | basenc --base64url | head -c 32`
sql_root_pass=`head /dev/random | basenc --base64url | head -c 32`
wp_pass=`head /dev/random | basenc --base64url| head -c 32`
vault_pass=`head /dev/random | basenc --base64url| head -c 64` > vault.key

cp playdoh/group_vars/vagrant.yml.bak playdoh/group_vars/vagrant.yml

sed -i "s/^sql_password:.*$/sql_password: ${sql_pass}/" playdoh/group_vars/vagrant.yml
sed -i "s/^sql_root_password:.*$/sql_root_password: ${sql_root_pass}/" playdoh/group_vars/vagrant.yml

ansible_vault encrypt playdoh/group_vars/vagrant.yml vault.key

