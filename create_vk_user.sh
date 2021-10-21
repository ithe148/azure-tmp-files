#!/bin/bash


work_dir="/tmp/tm_dir_for_create_user"
postgres_local_user="postgres"
postgres_vk_db="vkplatform"
new_domain="$1"
new_user="$2"
new_pass="$3"

mkdir -p $work_dir
cd $work_dir

sudo -u $postgres_local_user psql -d $postgres_vk_db -c "INSERT INTO CLIENTGENERAL.DOMAINS (NAME) (SELECT '$new_domain' WHERE NOT EXISTS (SELECT * FROM CLIENTGENERAL.DOMAINS WHERE NAME = '$new_domain'));"
id_new_domain=`sudo -u $postgres_local_user psql -d $postgres_vk_db -c "SELECT id from CLIENTGENERAL.DOMAINS WHERE name='$new_domain';" | awk '{print $1}' | sed -n 3p`



sudo -u $postgres_local_user psql -d $postgres_vk_db -c "INSERT INTO CLIENTGENERAL.USERS(NAME, DOMAIN_ID, DIRECTORY, STATE)  (SELECT '$new_user', $id_new_domain, 2, 3 WHERE NOT EXISTS (SELECT * FROM CLIENTGENERAL.USERS WHERE NAME = '$new_user'));"

id_new_user=`sudo -u $postgres_local_user  psql -d $postgres_vk_db -c "SELECT id from CLIENTGENERAL.USERS WHERE name='$new_user';" | awk '{print $1}' | sed -n 3p`


wget https://vkstorageacctest.blob.core.windows.net/vktest/password_util.zip
rm -rf Password
unzip password_util.zip && cd Password/
encrypt_new_pass=`./password.sh encrypt $new_pass`

sudo -u postgres psql -d $postgres_vk_db -c "UPDATE CLIENTGENERAL.PASSWORDS SET ID = '$id_new_user', USER_ID = '$id_new_user', HASH = '$encrypt_new_pass', RECENT = TRUE WHERE USER_ID = '$id_new_user';"
sudo -u postgres psql -d $postgres_vk_db -c "INSERT INTO CLIENTGENERAL.PASSWORDS(ID, USER_ID, HASH, RECENT ) (SELECT '$id_new_user', '$id_new_user', '$encrypt_new_pass', TRUE WHERE NOT EXISTS (SELECT * FROM CLIENTGENERAL.PASSWORDS WHERE USER_ID = '$id_new_user'));"

cd /

rm -rf $work_dir
