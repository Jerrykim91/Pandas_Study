# Kaggle(캐글) API

## Kaggle API 설치

Kaggle API 설치는 pip 패키지로 인스톨해주시면 됩니다.

```bash
!pip install kaggle # 기본
!pip install kaggle --upgrade # 업그레이드 
```

## Kaggle API 토큰 다운로드 (.json 파일)

1. 캐글에 로그인 
2. 어카운트로 접속 : `https://www.kaggle.com/<username>/account`
3. 캐글에서 어카운트로 접속한 다음 -> Create New API Token로 접속한다.
    - Token => kaggle.json 파일이 다운로드


## 받은 kaggle.json 파일을 이동
- 다운로드 받은 kaggle.json 파일을 각 os별로 해당 위치로 이동


### Windows
`C:\Users\<Windows-username>\.kaggle\kaggle.json`


## Command
- Kaggle API는 다음과 같은 command를 지원

```cmd
kaggle competitions {list, files, download, submit, submissions, leaderboard}
kaggle datasets {list, files, download, create, version, init}
kaggle kernels {list, init, push, pull, output, status}
kaggle config {view, set, unset}

```

## Competition List 
- command line 명령어로 진행중인 kaggle competition의 리스트를 확인
`kaggle competitions list`


## 데이터셋 다운로드 하기 
- 경진대회의 데이터셋을 Kaggle API를 통해 다운로드한다.
- 데이터셋을 받고자 하는 디렉토리로 이동한 뒤 위에서 copy한 명령어를 입력한다.

```py
# 대회이름 데이터셋 다운로드
kaggle competitions download -c 대회이름
```
- 다운로드 받은 titanic.zip 파일의 압축
- 압축을 풀어주니 train.csv, test.csv, submission.csv 파일이 생겼음


## 제출하기(Submission API)

- Submission 주소로 이동
- 해당 파일에 Command Line 명령어 복사 
    - 내가 제출할 .csv 파일이 있는 디렉토리로 이동
    - 위에서 복사한 명령어를 입력해주면 제출 완료 
    - 주의 
        -  `-f` 옵션 뒤에는 내가 제출할 `.csv` file 이름을 적어 줘야함 
        -  `-m` 옵션 뒤에는 제출할 때 간단한 message를 남길 수 있음   

만약 이같은 메세지가 뜬다면 `Successfully submitted to Titanic: Machine Learning from Disaster(kaggle)` 성공적으로 제출한것이다.  
My Submissions를 refresh 해보면 내가 기록한 message와 함께 정상적으로 제출되었음을 확인 가능하다. 

