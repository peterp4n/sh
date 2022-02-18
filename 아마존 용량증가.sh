
0.  참고 
https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html
1. aws.amazon.com 에서 볼륨 용량 확장
   ec2 대시보드 > EBS > 볼륨 > ebs 선택 > 볼륨 수정 > 크기 수정

2. Linux 파일 시스템 확장 
$ df -hT
$ lsblk
$ lsblk -f
$ sudo growpart /dev/xvda 1
$ lsblk
$ xfs_growfs -d /

## 파일시스템  ext2, ext3, ext4 일때 사용
$ resize2fs /dev/xvda1 

## 파일시스템 xfs 일때 사용
$ xfs_growfs /dev/xvda1 

$ df -h
$ fdisk -l

