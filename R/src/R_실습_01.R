# 변수 -> 데이터 저장 공간 
# 변수 네이밍 규칙 
# 대소문자 구별 
# 특수문자 불가능 
# 밑줄이나 마침표기호 -> 가능 
# 변수아름의 첫 글자로 숫자나 밑줄 -> 불가능 
# 하지만 중간에 들어가는 것은 가능하다. 
# if, while, for 등의 예약어 -> 불가능 


# 실습 

### v 라는 변수에 10을 담아라!
v <- 10 
v

### 변수 이름 명명 규칙중 하나이다. 에러가 발생하지 않도록 수정해라!

_UnderbarUseIt <- 10 
_UnderbarUseIt

# 수정안 
Underbar_Use_It <- 10 
Underbar_Use_It

3NumberUseIt <- 10 
3NumberUseIt

# 수정안 
Number0Use0It <- 10 
Number0Use0It

for <- 10
for 

# 수정안 
UseFor <- 10
UseFor 

### 변수의 데이터형을 모두 참으로 출력하라
x <- 1
is.integer(x) # numeric # 정수취급이 안된다.
# is.numeric(x) 
### 데이터 형 변환을 해보자 
x <- as.integer(x) # 데이터 형변환 
x
is.integer(x)

x <- 1.8L
is.integer(x) 
# 에러발생 : integer literal 1.8L contains decimal; using numeric value

x <- 1L
is.integer(x) # integer

a <- "Hello world!"
is.character(a)

### 데이터형 변환을 해보자 
# as.factor(a)[c(1)]

b <- 3.14i
is.complex(b)

n <- NA
is.na(n)


### 데이터 구조에 설명하라 

## 단일한 값의 데이터가 들어있는 경우 

# 벡터  -> 1 * x
# 매트릭스 -> 2 * x
# 어레이 -> 3 * x

## 복합적인 데이터가 들어있는 경우
# 데이터 프레임
# 리스트s


### 순차벡터를 이용하여 1~10까지 짝수만 출력하라(변수명은 t이다.)
t <- seq(0, 10, 2)
t[-c(1)]

### 반복벡터를 이용하여 





############################################################################################

#### 1차 실습 

ran_num <- c(1:30)
ran_contry <-rep(c("한국","미국","중국"), times=ran_num)
ran_fruit <- rep(c("사과","포도","배"), times=ran_num)
ran_price <- rep(seq(1000, 4000, 1000), times=ran_num)
col_num <- 6 

store <- data.frame(fruit = sample(ran_fruit, col_num), price = sample(ran_price, col_num), contry = sample(ran_contry, col_num), stock = sample(ran_num, col_num) )
store

# 1. 사과에 대한 정보를 추출해보자 ! 추가로 원산지와 금액을 추출해보자 ! (당근이름있어야디)
store[store$fruit == "사과",]
store[store$fruit == "사과", -c(4)]
fruit_kind<- factor(fruit)
fruit_kind[1:3]

# 2. 사과와 배의 두개의 평균금액을 구해보자 !

apple_total_price <- store[store$fruit == "사과", c("price")]
pare_total_price <- store[store$fruit == "배", c("price")]
mean(apple_total_price)
mean(pare_total_price)

# 3. 배가 평균금액보다 큰 원산지를 추출하라!
subset(store, price > mean(pare_total_price), select = c(contry,price))



#### 실습 2(개인)

### 구구단을 외자 ! 

### for 문 이용
for( i in 2:9){
    print(paste(i,"단"))
    for(j in 1:9){
        result = i * j
        print(paste( i ,"x", j,"=", result))
    }
}

### while + for 

i <- 1   # 선언 
while(i<10){
    print(paste(i,"단"))
    for(j in (2:9)){
        result = i * j
        print(paste( i ,"x", j,"=", result))
    }
    i = i + 1 
}

### 순수 while

i <- 1   # 선언 
j <- 1
while(i<10){
    print(paste(i,"단"))
    while(j<10){
        result = i * j
        print(paste( i ,"x", j,"=", result))
        j = j + 1 
        # break
    }
    i = i + 1 
    j <- 1
}

### 

#### 실습 2

### 1. 2~9단까지 구구단을 외자 ! 

### for 문 이용
for( i in 2:9){
    print(paste(i,"단"))
    for(j in 1:9){
        result = i * j
        cat(i ,"x", j,"=", result,'\n')
        # print(paste(i ,"x", j,"=", result))
    }
}

### 2-1. 1부터 100까지의 수중에서 3의 배수이면서 4의 배수는 아닌 수의 합을 구하여라 

# 1- 100까지 가지고 오고 
result <- 0
for(i in seq(1, 100)){
    if (i %% 3 == 0){ # 3의 배수만 출력 
        if (i %% 4 != 0){ # 그중에 만약 4의 배수가 아니면 출력
            result = result + i
        }
    }
}
print(result)

### 2-2. 연산을 통해서 진행 

result <- 0
for(i in seq(1, 100)){
    if (i %% 3 == 0 & i %% 4 != 0){ # 3의 배수만 출력 
        result = result + i
    }
}
print(result)
    
### 3. x와 n을 입력하면 1부터 100 까지의 수중에서 x 배수의 합을 구해주는 사용자 함수를 만들어라 
func <- function(x, n) {
    result <- 0
    for(i in seq(1, n)){
        if (i %% x == 0){ 
            result = result + i
            print(result)
        }
    }
}

func(3, 100)

### 3-1.
func <- function(x, n) {
    result <- 0
    i <- 0
    while(i < n ){
        if (i %% x == 0){ 
            result = result + i
        }
        i = i + 1
    }
print(result)
}

func(3, 100)


### 3-2 . 다시해보기 
multipsum <- function(x,n){
  start <- 1:n
  return(cat("1부터",n,"까지의 수 중에서",x,"의 배수 합은",
             sum(start[start%%x == 0]),"입니다."))
}

multipsum(3,100) 


#각 나라country의 기대 수명lifeExp
gapminder %>% filter(country == country[1] & year >1990 )%>%select(country,lifeExp,pop)


### 실습 3

install.packages("gapminder")
install.packages("dplyr")
library(gapminder) 
library(dplyr)
glimpse(gapminder)

table(gapminder$country)
summary(gapminder$country)

grep("Korea", gapminder$country, value=T)
gapminder$country[grep("Korea", gapminder$country)]

# 문제 1. [gapminder 연습] 우리나라의 1990년도 이후의 기대 수명과 인구 추출
gapminder[gapminder$country == "Korea, Rep."&gapminder$year>1990,c("lifeExp","pop")]
gapminder %>% filter(country == "Korea, Rep." & year >1990 )%>%select(lifeExp,pop)

# 문제 2.[gapminder 연습] 북한의 1990년도 이후의 기대 수명과 인구 추출
gapminder[gapminder$country == "Korea, Dem. Rep."&gapminder$year>1990,c("lifeExp","pop")] 
gapminder %>% filter(country == "Korea, Dem. Rep." & year >1990 )%>%select(lifeExp,pop)