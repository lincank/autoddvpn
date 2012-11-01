# Anti-GFW tools

此代码库是本人在使用[autoddvpn](http://autoddvpn.googlecode.com/)及[dd-wrt](http://www.dd-wrt.com/)固件过程中总结出来的一些经验和常用的脚本，目标是在此基础上搞出一套能自动更新的方案。经验有限，有什么错误或不足请及时告诉我，以免误导他人。


在路由器层面上作文章，最大的好处就是让所以连接此路由的设备都能无痛翻墙，而且不影响国内网站的使用。



## 必要条件

只要在[Support List](http://www.dd-wrt.com/wiki/index.php/Supported_Devices)找得到的路由器，再找到相应的版本，基本上都能刷dd-wrt。但能刷dd-wrt不见得能使用autoddwrt，要使用autoddvpn，有以下一些条件：

* 一个PPTP或OpenVPN账号
* 有PPTP或OpenVPN，且支持JFFS的ddwrt固件
* 路由在刷完dd-wrt固件后，Flash里还至少有几百kb的空间装脚本
* ADSL或DHCP上网环境
* 一颗折腾的心:)


> 注意分清楚路由的Flash和RAM，Flash才是装固件的，而RAM就是一般意义上的内存，一般RAM会比较大一点。
> 理论上讲放在RAM也是可以的，不过在断电后又要把这些东西装进去:P

## autoddvpn配置
有关如何使用[autoddvpn](https://code.google.com/p/autoddvpn/)，它里面的文档说得很详细，不再赘述。这里的只是让你更好地使用它。

## 使用心得

### DNS
autoddvpn的文档里说开启dnsmasq后，静态dns不填，这样使用你本地ISP的DNS。其实除了为防止DNS污染而手动添加的地址外，dnsmasq还会使用几个name server来查询其他还没在dnsmasq缓存的域名，具体在路由里的`/tmp/resolv.dnsmasq`可以看到。如果为空的话，dnsmasq会使用ISP的name server。一些外国网站本地DNS没有，所以我加上了google的DNS，再加上经常用Apple Store，所以也用了[V2EX DNS](http://dns.v2ex.com)。即是，第一个静态DNS填上V2EX的，第二个填Google的，然后dnsmasq会将ISP的DNS作为第三个。结果：

    root@dd-WRT:~# cat /tmp/resolv.dnsmasq 
    nameserver 199.91.73.222
    nameserver 8.8.8.8
    nameserver 202.96.128.166

第一和第二是在网页上设定的，分别是V2EX和Google，第三个是dnsmasq自动获取到的电信DNS。这样你打开一个网站时的查询顺序：

1. 自定的dnsmasq option里的地址 
2. V2EX DNS
3. Google DNS
4. ISP DNS

>以上的Google DNS也可以换成OpenDNS

这样设置的实际使用效果还不错。

### 定时重连
使用后发现，有时候路由开着几天后网速就下来了，但重新连接又正常，这时可以让它每两天自动连接一下，当然VPN也重新连接。相关脚本参见`scripts/reconnect.sh`。

如要单独要重新连接VPN，可参见`scripts/reset_vpn.sh`


### 版本
有8M Flash的路由，能刷全功能的Mega版，所以基本都没问题。Flash比较小的，如4M，使用有`openvpn`后缀的固件同样也可以。所以在选择路由时可以参考[Support List](http://www.dd-wrt.com/wiki/index.php/Supported_Devices)的路由参数，再找找看这个路由对应的有哪些版本可以刷。找那些在网上有成功案例的最好不过了:)

Flash越大，选择的空间也大，但相应的价格也高，具体就看需求了。

### 可利用空间
有时候ddwrt刷进去了，OpenVPN及JFFS啥的也都支持，但页面上显可用空间为**0 kb**！这时，如果你刷的是Mega，可以试一些功能删减的版本，无大碍。实在不想换，有以下方案：

* 如果路由支持USB，可以将这些脚本放在外接的USB设备上
* 如果路由不支持USB，可以自己将原有固件做修改，删减一些你没用到的功能，释放空间，可参见[ddwrt官网](http://www.dd-wrt.com/wiki/index.php/Development#Modifying_the_firmware_.28manual_and.2For_ipkg_install.sh.29)


