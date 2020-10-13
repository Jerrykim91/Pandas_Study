## 실습 - 리스트 

#########################################################

## 리스트
patients <- data.frame(name = c("하나", "두나", "세나"), 
                      age = c(22, 20, 25), 
                      gender = factor(c("M", "F", "M")), 
                      blood = factor(c("A", "O", "B")))
no.patients <- data.frame(day = c(1:6), 
                         no = c(50, 60, 55, 52, 65, 58))


# 데이터를 단순 추가
listPatients <- list(patients, no.patients) 
listPatients

# 각 데이터에 이름 부여하면서 추가
listPatients <- list(patients=patients, no.patients = no.patients) 
listPatients

listPatients$patients		# 요소명 입력

listPatients[[1]]				# 인덱스 입력

listPatients[["patients"]]			# 요소명을""에 입력

lapply(listPatients$no.patients, mean) # 평균 구하기

sapply(listPatients$no.patients, mean) 

#########################################################
