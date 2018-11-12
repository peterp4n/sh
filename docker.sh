

### docker-compose
1. install
    참조 : https://docs.docker.com/compose/install/#install-compose
    # sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o //bin/docker-compose
    # chmod +x /bin/docker-compose
    

2. 명령
	#도커 이미지 목록
	docker images

	#도커 컨테이너 전체 목록
	docker container ls -all

	#도커 실행중인 목록
	docker ps

	#도커 컨테이너 전체 목록
	docker ps -a

	# 컨테이너 정지	
	$ docker stop `docker ps -a -q`
	
	#도커 죽이기
	docker kill 컨테이너id

	#도커 삭제하기
	docker rm [컨테이너id]  
	$ docker rm [컨테이너id] [컨테이너id]  

	#도커 이미지 삭제하기
	$ docker rmi 컨테이너 id 
	$ docker rmi `docker images -q`

	#Compose 파일로 컨테이너 생성(-d : 백그라운드 실행), docker-compose.yml파일이 있는곳 실행
	docker-compose up -d

	#Compose 파일에 정의 된 서비스 용 컨테이너 제거
	docker-compose down

	#도커 이미지 생성 및 태그 부여(현재지점)
	#tag명:버전 (입력하지않으면 latest로 입력되고 생성할대 마다 이미지가 계속 쌓인다)
	docker build -t 태그명 .

	#도커 이미지 실행
	#-d : 백그라운드 실행
	docker run -p 내컴퓨터포트:도커연결할포트 태그명 -d

	#로그보기
	docker logs 컨테이너id

	#도커로그인
	docker login

	#도커이미지 복사하기
	docker tag 내컴퓨터에있는이미지명 계정명/생성할이미지명:생성할태그명

  
	#도커hub에 이미지 업로드
	docker push 계정명/이미지명:태그명

	#도커서비스 목록
	docker service ls
	docker service ps 서비스명

	#도커 swam시작하기(라운드로빈가능)
	docker swarm init

	#docker swam join문을 실행하여 다른 컴퓨터와 연결할 수 있다.
	docker swarm join --token 토큰키 아이피:포트

	#docker yml설정 파일 기반으로 swam실행하고 이름 지정하기
	docker stack deploy -c docker-compose.yml swam생성이름
	#docker-compose.yml 예제
		version: "3"
		services:
			web:
				# replace username/repo:tag with your name and image details
				image: username/repo:tag
				deploy:
					replicas: 5
					resources:
						limits:
							cpus: "0.1"
							memory: 50M
					restart_policy:
						condition: on-failure
				ports:
					- "80:80"
				networks:
					- webnet
		networks:
			webnet:

	#docker swam 서비스중인 목록
	docker service ls

	#docker swam 이름으로 실행중인 서비스 목록 보기
	docker service ps swam생성이름

	#docker swam 종료
	docker swarm leave --force

	#docker swam 제거
	docker stack rm swam생성이름

 
