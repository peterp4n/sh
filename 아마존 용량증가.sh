1. aws.amazon.com 에서 볼륨 용량 확장

2. Linux 파일 시스템 확장 
$ lsblk
$ lsblk -f
$ sudo growpart /dev/xvda 1
$ lsblk

## 파일시스템  ext2, ext3, ext4 일때 사용
$ resize2fs /dev/xvda1 

## 파일시스템 xfs 일때 사용
$ xfs_growfs /dev/xvda1 

$ df -h
$ fdisk -l
