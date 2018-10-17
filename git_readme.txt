GIT 작업하기

https://rogerdudler.github.io/git-guide/index.ko.html

1. git add 작업폴더/파일
2. git commit -m "문구"
3. git status
4. git push
5.마스터폴더 이동
6. git pull 



※ git pull 충돌시 해결 방법 정리
1. git stash 
2. git pull
3. git stash pop







1. git clone [git주소] [작업디렉토리]
2. git add .
3. git commit -m 'init'
4. git push origin master



### 브랜치 분기 작업방법 
git checkout develop
git add .
git commit -m '문구'
git push
git checkout master
git merge master
git push


 
### 브랜치 종류
master : 최종 릴리즈한 안정화 버전
develop : 다음 릴리즈를 위해 개발중인 최신 버전
feature : 특정 기능 개발을 위한 branch
release : 릴리즈 점검을 위한 branch
hotfix : 긴급 버그 픽스를 위한 branch
support : 버전 호환성 문제 처리를 위한 branch

