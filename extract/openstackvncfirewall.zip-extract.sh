#!/bin/sh -x


[ ! -d extracted ] && mkdir extracted
cd extracted
unzip -o ../../openstackvncfirewall.zip
ls -l vendor-index.xml metadata.zip index.xml vib20/OpenStackVNC/*.vib
chmod 0644 vendor-index.xml metadata.zip index.xml vib20/OpenStackVNC/*.vib
ls -l vendor-index.xml metadata.zip index.xml vib20/OpenStackVNC/*.vib


# VMware_bootbank_OpenStackVNC_5.0.0-0.0.1.vib -> vnc
# http://www.yellow-bricks.com/2011/11/29/how-to-create-your-own-vib-files/
cd vib20/OpenStackVNC
if [ ! -f vnc ]; then
  if [ ! -x /usr/bin/ar ]; then
    echo /usr/bin/ar does not exist in ESXi. Try Linux.
    exit
  fi
  /usr/bin/ar vx VMware_bootbank_OpenStackVNC_5.0.0-0.0.1.vib
fi
ls -l descriptor.xml sig.pkcs7 vnc
chmod 0644 descriptor.xml sig.pkcs7 vnc
ls -l descriptor.xml sig.pkcs7 vnc


# vnc -> vnc.tar.vtar
gunzip < vnc > vnc.tar.vtar
ls -l vnc.tar.vtar


# vnc.tar.vtar -> vnc.tar
if [ ! -f vnc.tar ]; then
  if [ -f vnc.tar.vtar ]; then

    if [ ! -x /bin/vmtar ]; then
      echo /bin/vmtar only exists in VMware ESXi.
      echo Copy vnc.tar.vtar to ESXi and rerun.
      exit
    fi
    vmtar -v -x vnc.tar.vtar -o vnc.tar
  fi
fi


ls -l vnc.tar
tar xvf vnc.tar
ls -l etc/vmware/firewall/vnc.xml
cat etc/vmware/firewall/vnc.xml
echo "done"
exit

