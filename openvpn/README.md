This installs openvpn so clients can connect using OpenVPN client via HTTPS

You have to make an AWS EC2 CentOS 7 instance first, then put the public IP in hosts and execute.

script makecredentials.sh is used to generate keys/config for end users, tgz file dropped in /home/centos/

You need at least 1 GiB RAM to do the ansible installation. After that can reduce.