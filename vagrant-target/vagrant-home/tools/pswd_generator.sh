#!/bin/sh

role_path="/home/vagrant/playdoh/roles/install_inception"

sql_pass=`head /dev/random | basenc --base64url | head -c 32`
sql_root_pass=`head /dev/random | basenc --base64url | head -c 32`
wp_pass=`head /dev/random | basenc --base64url| head -c 32`
vault_pass=`head /dev/random | basenc --base64url| head -c 64` > ${role_path}/files/vault.key


sed -i "s/^sql_password:.*$/sql_password: ${sql_pass}/" ${role_path}/vars/vagrant.yml
sed -i "s/^sql_root_password:.*$/sql_root_password: ${sql_root_pass}/" ${role_path}/vars/vagrant.yml

ansible_vault encrypt ${var_path}/vagrant.yml ${role_path}/files/vault.key

