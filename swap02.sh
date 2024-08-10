#!/bin/bash

# 检查是否已有swap文件
if [ -f /swapfile ]; then
    echo "Swapfile already exists. Exiting."
    exit 1
fi

# 创建一个大小为3GB的swap文件
fallocate -l 3G /swapfile
if [ $? -ne 0 ]; then
    echo "Failed to allocate space for swapfile. Exiting."
    exit 1
fi

# 查看swap文件大小
ls -lh /swapfile

# 设置合适的权限，防止未授权访问
chmod 600 /swapfile
if [ $? -ne 0 ]; then
    echo "Failed to set permissions on swapfile. Exiting."
    exit 1
fi

# 创建swap文件
mkswap /swapfile
if [ $? -ne 0 ]; then
    echo "Failed to create swap on /swapfile. Exiting."
    exit 1
fi

# 启用swap分区
swapon /swapfile
if [ $? -ne 0 ]; then
    echo "Failed to enable swap on /swapfile. Exiting."
    exit 1
fi

# 查看是否生效
free -h

# 将swap分区配置添加到 /etc/fstab，以便开机自动挂载
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

# 确保配置文件中的swap已生效
mount -a
if [ $? -ne 0 ]; then
    echo "Failed to reload /etc/fstab. Exiting."
    exit 1
fi

echo "Swap setup completed successfully."
