#!/bin/sh -x

mkdir extracted
cd extracted
unzip -n ../../openstackvncfirewall.zip
cd vib20/OpenStackVNC

# http://www.yellow-bricks.com/2011/11/29/how-to-create-your-own-vib-files/
ar vx VMware_bootbank_OpenStackVNC_5.0.0-0.0.1.vib
chmod 700 vnc

# https://www.virtuallyghetto.com/2011/08/how-to-create-and-modify-vgz-vmtar.html
#gunzip < vnc > vnc.xz
#ls vnc.xz
#xz --single-stream --decompress < vnc.xz > vnc.vtar

# -ao[a=overwite_all_existing|s=skip_existing|u=rename_extracting_file|t=rename_existing_file]
7z x -aos vnc
ls vnc.tar.vtar

if [ ! -x /bin/vmtar ]; then
  echo /bin/vmtar only exists in VMware ESXi.
  exit
fi
vmtar -v -x vnc.tar.vtar -o vnc.tar
[ -x /bin/vmtar ] && vmtar -v -x vnc.tar.vtar -o vnc.tar
ls vnc.tar

# tar -tvf vnc.tar
tar -xvf vnc.tar
