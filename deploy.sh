#!/bin/bash -e

#paths
project_name="hello_flask"
project_dir="/home/ubuntu/$project_name"
binary="$project_dir/hello.py"
runit_dir="/etc/service/$project_name"
log_dir="/var/log/$project_name"

#general:
sudo apt-get update
sudo apt-get install git python-pip runit -y
sudo pip install flask

#prepare runit:
sudo mkdir -p "$runit_dir/log"

cat >/tmp/run <<EOF
#!/bin/bash -e
exec 2>&1
exec python "$binary"
EOF
sudo mv /tmp/run "$runit_dir/run"
sudo chmod +x "$runit_dir/run"

sudo mkdir "$log_dir"
cat >/tmp/log <<EOF
#!/bin/bash
exec svlogd -tt "$log_dir"
EOF
sudo mv /tmp/log "$runit_dir/log/run"
sudo chmod +x "$runit_dir/log/run"

sudo sv start "$project_name"
