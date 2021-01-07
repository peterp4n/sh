ec2 볼륨 증가
0.  참고 
https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html
1. aws 대쉬보드
   ec2 대시보드 > 볼륨 > ec2 선택 > 볼륨 수정 > 크기 수정
2. console
   df -hT
   lsblk
   growpar /dev/xvda 1
   xfs_growfs -d /
   resize2fs /dev/xvda1
