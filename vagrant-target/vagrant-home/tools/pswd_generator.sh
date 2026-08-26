#!/bin/sh

role_path="/home/vagrant/playdoh/roles/install_inception"

sql_pass=`head /dev/random | basenc --base64url | head -c 32`
sql_root_pass=`head /dev/random | basenc --base64url | head -c 32`
wp_pass=`head /dev/random | basenc --base64url| head -c 32`
head /dev/random | basenc --base64url| head -c 64 > ${role_path}/files/vault.key


sed -i "s/^sql_password:.*$/sql_password: ${sql_pass}/" ${role_path}/vars/main.yml
sed -i "s/^sql_root_password:.*$/sql_root_password: ${sql_root_pass}/" ${role_path}/vars/main.yml

 ansible-vault encrypt ${role_path}/vars/main.yml --vault-password-file ${role_path}/files/vault.key
 chown vagrant:vagrant ${role_path}/vars/main.yml
 chown vagrant:vagrant ${role_path}/files/vault.key

