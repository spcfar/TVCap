##centos7服务器设置静态IP
	具体ip请自行设置,以下仅供参考
	vi /etc/sysconfig/network-script/ifcfg-<网卡名称>
	BOOTPROTO=STATIC
	ONBOOT=YES
	IPADDR=192.168.2.117
	GATEWAY=192.168.2.1
	NETMASK=255.255.255.0
	DNS1=192.168.2.1
	
	重启网络服务
	service network restart
	
##安装install
	解压install后进入install文件夹
	输入 sh install.sh,回车
	等待即可