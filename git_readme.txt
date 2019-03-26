GIT 작업하기

https://rogerdudler.github.io/git-guide/index.ko.html


### 작업변경 내용 색상으로 비교 
git diff --color-words

### 작업변경 내용 단어로 비교
git diff --word-diff

### 작업취소
git checkout -- 취소할파일명


### commit 취소
gitreset --soft commit번호


### 전체 추가 작업방법 
git status
git add -p
git add 작업폴더/파일
git diff -staged
git commit -v
git commit -m '문구'  
git status
git push
git checkout master
git pull 
git merge master
git push
 

### 부분 추가 작업방법 
git add file1 file2 
git commit file1 file2 -m '문구' 
git push
git checkout master
git merge master
git pull
git push



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

