# 获取硬盘名
DISK=$1
DISK_FULL_PATH=${1}1
MOUNT_PATH=$2   #/data



# 检查硬盘是否存在
CHECK_DISK_EXIST=`/sbin/fdisk -l 2> /dev/null | grep -o "/dev/$DISK"`
[ ! "$CHECK_DISK_EXIST" ] && { echo "Error: Disk is not found !"; exit 1;}

# 检查硬盘是否已存在分区
#CHECK_DISK_PARTITION_EXIST=`/sbin/fdisk -l 2> /dev/null | grep -o "/dev/$DISK[1-9]"`
#[ ! "$CHECK_DISK_PARTITION_EXIST" ] || { echo "WARNING: ${CHECK_DISK_PARTITION_EXIST} is Partition already !"; exit 1;}

# 开始格式化
/sbin/fdisk /dev/$DISK<<EOF &> /dev/null
n
p
1


t
83
wq
EOF

#刷新硬盘
partx -a /dev/$DISK
echo "xfs分区"
mkfs.ext4 -O project,quota  $DISK
echo "Disk Partition Create OK!"
echo "设置ext4  pjquota自动挂载" && sleep 2
UUID=$(blkid $DISK_FULL_PATH | cut -d" " -f2) ; echo "$UUID $MOUNT_PATH  ext4  rw,prjquota  0 0" >> /etc/fstab
echo "使用mount -a 自动挂载磁盘" && sleep 2
mount -a 
df -h |grep $MOUNT_PATH 
