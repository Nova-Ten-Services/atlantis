#!/bin/bash
vpn_name=VPN_NAME
cd /etc/openvpn/easy-rsa
clear
echo
echo username is $1 and PEM pass phrase is: $2
echo
/etc/openvpn/easy-rsa/easyrsa gen-req $1
clear
echo
echo -n "you will need the passphrase for ca.key to sign the new key: "
cat /etc/openvpn/ca-passphrase.txt
echo
/etc/openvpn/easy-rsa/easyrsa sign-req client $1
TEMP_DIR=`mktemp -d -t openvpn-XXXXXXXXXXX`
cp /etc/openvpn/client/ca.crt $TEMP_DIR
cp /etc/openvpn/client/ta.key $TEMP_DIR
sed 's/USERNAME/'${1}'/g' /etc/openvpn/client/$vpn_name.ovpn > $TEMP_DIR/$vpn_name.ovpn
cp /etc/openvpn/easy-rsa/pki/private/${1:-username}.key $TEMP_DIR
cp /etc/openvpn/easy-rsa/pki/issued/${1:-username}.crt $TEMP_DIR
chown -R centos:centos $TEMP_DIR
chmod -R 777 $TEMP_DIR
cd $TEMP_DIR
ls -la
rm -f /home/centos/${1:-username}-$vpn_name-keys.7z
7za a -p${2:-password} /home/centos/${1:-username}-$vpn_name-keys.7z ./*
chown centos:centos /home/centos/${1:-username}-$vpn_name-keys.7z
echo "your file is here: /home/centos/${1:-username}-$vpn_name-keys.7z"
srm -rf $TEMP_DIR