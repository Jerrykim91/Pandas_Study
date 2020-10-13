## 실습 - 데이터프레임

#########################################################

## 데이터프레임 -> data.frame()
name <- c("하나", "둘", "셋")
age <- c(22, 20, 25)
gender <- factor(c("M", "F", "M"))
blood <- factor(c("A", "O", "B"))
patients <- data.frame(name, age, gender, blood)
patients

# edit함수 이용해 데이터프레임 생성
test<-data.frame()
test<-edit(test)
test

#########################################################

## 데이터 프레임 요소에 접근 : $, [,]
patients
patients$name # name 속성값 출력
patients[1, ] # 1행 값
patients[, 2] # 2열 값
patients[3, 1] # 3행 1열 값
patients[patients$name=="하나", ] #하나에 대한 정보 추출
patients[patients$name=="하나", c("name", "age")] #하나의 이름과 나이 추출

#########################################################

## 데이터프레임에 유용한 함수

# cars 데이터셋 확인
head(cars) 
speed

### attach(), detach(), subset()

# attach 속성을 변수로 만듬
attach(cars) 
speed # speed 변수명 이용 가능

# detach 속성의 변수사용 해제
detach(cars) 
speed 

# 데이터 속성을 이용해 함수 적용
mean(cars$speed)
max(cars$speed)

mean(speed)
attach(cars) # attach 속성을 변수로 만듬
mean(speed)
max(speed)


# subset 일부 데이터만 추출
subset(cars, speed > 20) # 속도가 20초과인 데이터
subset(cars, speed > 20, select = c(dist)) # 속도 20초과, dist 열 추출
subset(cars, speed > 20, select = -c(dist)) # 속도 20초과, dist 열 제외

#########################################################
