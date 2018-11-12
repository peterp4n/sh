

### docker-compose
1. install
    참조 : https://docs.docker.com/compose/install/#install-compose
    # sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o //bin/docker-compose
    # chmod +x /bin/docker-compose
    

2. 컨테이너
	# 컨테이너 정지	
    $ docker stop `docker ps -a -q`

	# 컨테이너 확인
    $ docker ps
    $ docker ps -a

	# 컨테이너 삭제
    $ docker rm [컨테이너id]
    $ docker rm [컨테이너id], [컨테이너id]  
    $ docker rm `docker ps -a -q`
 
3. 이미지 
	# 이미지 삭제
    $ docker images
    $ docker rmi [이미지id]
 
	# 컨테이너 이미지 삭제
	$ docker rmi $(docker images -q)



  

 
