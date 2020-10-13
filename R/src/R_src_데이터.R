## 실습 - 데이터

#########################################################

## 파일 읽고 쓰기 -> 데이터는 미공개
# 파일 마지막 행에서 [Enter]를 누르지 않은 경우
students <- read.table("C:/r/students1.txt", header = T) 

# 파일 마지막 행에서 [Enter]를 누른 경우
students <- read.table("C:/r/students.txt",  header = T) 
students

# 읽은 파일의 구조 확인
str(students) 

# 파일을 있는 형태 그대로 읽음
students <- read.table("C:/r/students.txt", header = T, as.is = T) 
str(students)

# 파일을 읽을 때 문장을 요인으로 인식하지 않도록 설정
students <- read.table("C:/r/students.txt", header = T, stringsAsFactors = F) 
str(students)

# read.csv 함수: CSV(Comma-Separated Values) 파일을 읽을 때 사용
# 첫 행이 header이므로 header 옵션을 지정할 필요가 없음
students <- read.csv("C:/r/students.csv") 
students

# 읽은 파일의 구조 확인
str(students) 

# name 속성을 요인에서 문장으로 변경
students$name <- as.character(students$name) 
str(students)

# stringsAsFactors -> 파일을 읽을 때 문장을 요인으로 인식하지 않도록 설정함
students <- read.csv("C:/r/students.csv", stringsAsFactors = FALSE) 
str(students)


# write.table 큰따옴표 여부 
# 1. 문장에 큰따옴표가 표시됨.
write.table(students, file = "C:/r/output1.txt") 

# 2. 문장에 큰따옴표되지 않음.
write.table(students, file = "C:/r/output1.txt", quote = F) 

#########################################################

## 결측값 처리 
# is.na 함수를 이용해 결측값 처리하기
str(airquality)	# airquality 데이터의 구조를 살펴봄.

# airquality 데이터에서 NA는 TRUE, 아니면 FALSE. 
head(is.na(airquality))	
table(is.na(airquality))	# NA가 총 44개 있음.


table(is.na(airquality$Temp))	# Temp에는 NA가 없음을 확인함.
table(is.na(airquality$Ozone))	# Ozone에는 NA가 37개 발견됨.

mean(airquality$Temp)		# NA가 없는 Temp는 평균이 구해짐.
mean(airquality$Ozone)		# NA가 있는 Ozone은 평균이 NA로 나옴.

# Ozone 속성에서 NA가 없는 값만 추출함.
air_narm <- airquality[!is.na(airquality$Ozone), ]  
air_narm
mean(air_narm$Ozone)	# 결측값 제거후 mean 함수 동작

# na.omit 함수를 이용해 결측값 처리하기
air_narm1 <- na.omit(airquality)
mean(air_narm1$Ozone)

# 함수 속성인 na.rm을 이용해 결측값 처리하기
mean(airquality$Ozone, na.rm = T)

#########################################################

## 이상값 처리
# 이상값이 포함된 환자 데이터
patients <- data.frame(name = c("하나", "두나", "세나", "네나", "다나"), 
                       age  = c(22, 20, 25, 30, 27), 
                       gender = factor(c("M", "F", "M", "K", "F")), 
                       blood  = factor(c("A", "O", "B", "AB", "C")))

# 성별에서 이상값 제거
patients_outrm <- patients[patients$gender=="M"|patients$gender=="F", ]
patients_outrm	

# 성별과 혈액형에서 이상값 제거
patients_outrm1 <- patients[(patients$gender == "M"|patients$gender == "F") 
                            & (patients$blood == "A"
                               |patients$blood == "B"
                               |patients$blood == "O"
                               |patients$blood == "AB"), ]
patients_outrm1	 

# 성별은 남자는 1, 여자는 2로 표시, 혈액형은 A, B, O, AB형을 각각 1, 2, 3, 4로 표현
# 이상값이 포함된 환자 데이터
patients <- data.frame(name = c("하나", "두나", "세나", "네나", "다나"), 
                       age  = c(22, 20, 25, 30, 27), 
                       gender = c(1, 2, 1, 3, 2), 
                       blood  = c(1, 3, 2, 4, 5))	

# 성별에 있는 이상값을 결측값으로 변경
patients$gender <- ifelse((patients$gender<1|patients$gender>2), 
                          NA, patients$gender)
patients	

# 혈액형에 있는 이상값도 결측값으로 변경
patients$blood <- ifelse((patients$blood<1|patients$blood>4), 
                         NA, patients$blood)
# 결측값을 모두 제거
patients[!is.na(patients$gender)&!is.na(patients$blood), ]


# boxplot을 활용하여 정상값과 이상값을 구분
boxplot(airquality[, c(1:4)])    # Ozone, Solar.R, Wind, Temp에 대한 boxplot
boxplot(airquality[, 1])$stats   # Ozone의 boxplot 통계값 계산

air <- airquality                 # 임시 저장 변수로 airquality 데이터 복사
table(is.na(air$Ozone))          # Ozone의 현재 NA 개수 확인

# 이상값을 NA로 변경
air$Ozone <- ifelse(air$Ozone<1|air$Ozone>122, NA, air$Ozone) 
table(is.na(air$Ozone)) # 이상값 처리 후 NA 개수 확인(2개 증가)

# NA 제거
air_narm <- air[!is.na(air$Ozone), ] 
mean(air_narm$Ozone) # 이상값 두 개 제거로 is.na 결과보다 값이 줄어듦
boxplot(air_narm$Ozone)$stats

#########################################################