1. aws.amazon.com 에서 볼륨 용량 확장

2. Linux 파일 시스템 확장 
$ lsblk
$ lsblk -f
$ sudo growpart /dev/xvdf 1
$ lsblk
$ sudo resize2fs /dev/xvdf1
$ df -h



 
$ resize2fs /dev/nvme0n1p1
$ df -h
$ fdisk -l
