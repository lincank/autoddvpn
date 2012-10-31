# Anti-GFW tools

此代码库是本人在使用[autoddvpn](http://autoddvpn.googlecode.com/)及[dd-wrt](http://www.dd-wrt.com/)固件过程中总结出来的一些经验和常用的脚本，目标是在此基础上搞出一套能自动更新的方案。经验有限，有什么错误或不足请及时告诉我，以免误导他人。


在路由器层面上作文章，最大的好处就是让所以连接此路由的设备都能无痛翻墙，而且不影响国内网站的使用。



## 所用配置
* 一个能刷带OpenVPN的ddwrt的路由
* 一个PPTP或OpenVPN账号
* ADSL或DHCP上网环境
* 一颗折腾的心:)

## autoddvpn配置
有关如何使用[autoddvpn](https://code.google.com/p/autoddvpn/)，它里面的文档说得很详细，不再赘述。这里的只是让你更好地使用它。

## 使用心得

### DNS
autoddvpn的文档里说开启dnsmasq后，静态dns不填，这样使用你本地ISP的DNS。其实除了为防止DNS污染而手动添加的地址外，dnsmasq还会使用几个name server来查询其他还没在dnsmasq缓存的域名，具体在路由里的`/tmp/resolv.dnsmasq`可以看到。如果为空的话，dnsmasq会使用ISP的name server。一些外国网站本地DNS没有，所以我加上了google的DNS，再加上经常用Apple Store，所以也用了[V2EX DNS](http://dns.v2ex.com)。即是，第一个静态DNS填上V2EX的，第二个填Google的，然后dnsmasq会将ISP的DNS作为第三个。结果：

    root@dd-WRT:~# cat /tmp/resolv.dnsmasq 
    nameserver 199.91.73.222
    nameserver 8.8.8.8
    nameserver 202.96.128.166

第一和第二是在网页上设定的，分别是V2EX和Google，第三个是dnsmasq自动获取到的电信DNS

### 定时重连
使用后发现，有时候路由开着几天后网速就下来了，但重新连接又正常，这时可以让它每两天自动连接一下，当然VPN也重新连接。相关脚本参见`scripts/reconnect.sh`。

如要单独要重新连接VPN，可参见`scripts/reset_vpn.sh`
