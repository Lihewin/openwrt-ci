#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

sed -i 's/root::0:0:99999:7:::/root:$1$R43zhcLV$dwxtXXFI7TdIRcVKl.w3N1:20158:0:99999:7:::/g' /etc/shadow
#/etc/init.d/network restart

exit 0
