sed -i 's/192.168.1.1/192.168.13.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.13.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#sed -i 's/ImmortalWrt/Router/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i "s/ImmortalWrt/WiFi6/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/hanwckf/mtwifi.sh package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
mv $GITHUB_WORKSPACE/patch/hanwckf/199_mydef package/base-files/files/etc/uci-defaults/199_mydef

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

#红米ax6000改512MB闪存
#sed -i 's/reg = <0x600000 0x6e00000>/reg = <0x600000 0x1ea00000>/g' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7986a-xiaomi-redmi-router-ax6000.dts
#sed -i 's/reg = <0x600000 0x6e00000>/reg = <0x600000 0x1ea00000>/' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7986a-xiaomi-redmi-router-ax6000.dts
#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash

rm -rf feeds/packages/net/ddns-go
rm -rf feeds/packages/net/socat
rm -rf feeds/luci/applications/luci-app-ddns-go
rm -rf feeds/luci/applications/luci-app-socat
git clone --depth 1 https://github.com/sirpdboy/luci-app-advancedplus package/luci-app-advancedplus
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/luci-app-ddns-go
git clone --depth 1 https://github.com/sirpdboy/sirpdboy-package.git package/sirpdboy-package
mv package/sirpdboy-package/luci-app-socat package/luci-app-socat
rm -rf package/sirpdboy-package
git clone --depth 1 -b openwrt-23.05 https://github.com/immortalwrt/packages package/imm23pkg
mv package/imm23pkg/net/socat feeds/packages/net/socat
rm -rf package/imm23pkg

#有编译openwrt环境后，加入UA2F模块和RKP-IPID模块
#git clone https://github.com/EOYOHOO/UA2F.git package/UA2F
#git clone https://github.com/EOYOHOO/rkp-ipid.git package/rkp-ipid
#rm -rf feeds/packages/net/ua2f
#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po

# iStore
git clone --depth=1 https://github.com/xiangfeidexiaohuo/extra-ipk.git package/extra-ipk
mv package/extra-ipk/linkease package/linkease
rm -rf package/extra-ipk

#adguardhome，alist,frc,需要go版本需要最新的
git clone --depth=1 https://github.com/mingxiaoyu/luci-app-phtunnel.git package/phtunnel
git clone --depth=1 https://github.com/gdy666/luci-app-lucky.git package/luci-app-lucky
git clone --depth=1 https://github.com/kenzok8/small-package.git package/small-package
mv package/small-package/luci-app-adguardhome package/luci-app-adguardhome
mv package/small-package/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/small-package/homebox package/homebox
mv package/small-package/luci-app-netspeedtest package/luci-app-netspeedtest
rm -rf package/small-package

git clone --depth=1 https://github.com/coolsnowwolf/lede.git package/lede
mv package/lede/package/lean/luci-app-leigod-acc package/luci-app-leigod-acc
mv package/lede/package/lean/leigod-acc package/leigod-acc
rm -rf package/lede
