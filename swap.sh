fallocate -l 3G /swapfile #创建一个大小为3GB的swap文件
ls -lh /swapfile #查看swap文件大小
mkswap /swapfile #创建swap文件
swapon /swapfile #开启swap分区
free -h #查看是否生效
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab #配置 /etc/fstab 文件，让 swap 分区开机自加载
