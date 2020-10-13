#### 회귀 모델 

"""
대학생 90명의 키와 몸무게 데이터를 이용

## 실습순서

1. 데이터셋 읽어오기
2. 회귀모델 생성
3. 회귀계수 구하기
4. 회귀계수 값 검증하기
5. 잔차구하기
6. 잔차 제곱 합 구하기
7. 회귀 계수 신뢰구간 구하기
8. 새로운 학생 키로 몸무게 예측하기 
9. 모델 평가하기
"""

### 데이터 셋 로딩하기 
data_PATH <- file.path('C:\\', "data") # 경로 설정

## 대학생 92명의 키와 몸무게 데이터 
std_cnt_92 <- read.table(file.path(data_PATH, "student90.csv"),sep = ",",stringsAsFactors = FALSE,header = TRUE,na.strings = "")

# 데이터 확인
length(std_cnt_92$weight_kg) # 90개의 데이터 존재 -> 데이터 누락 데이터가 있는것 같음 
nrow(std_cnt_92)

# 데이터의 머리와 꼬리 확인 
head(std_cnt_92)
tail(std_cnt_92) # 2개의 데이터가 없는것 같음 

### 회귀 모델 생성 
## 대학생 90명의 키와 몸무게 데이터 셋을 이용한 회귀모델 생성하기 -> 몸무게 = 절편+ 개수 * 학생의 키
model <- lm(weight_kg~height_cm, data=std_cnt_92); model  #     32.6604       0.2247  

"""
# model
Call:
lm(formula = weight_kg ~ height_cm, data = std_cnt_92)

Coefficients:
(Intercept)    height_cm
    32.6604       0.2247  
"""

### 회계 계수  구하기 
## 대학생 90명의 키와 몸무게 데이터에서 몸무게와 키 생성된 회귀 모델에서 회귀계수 구하기 
coef(model)  # 32.6604144   0.2246605

### 예측값 구하기 
## 대학생 90명의 키와 몸무게 데이터에서 몸무게와 키 생성된 회귀모델로 예측값 찾기 

fitted(model)[1:4]

"""
       1        2        3        4
77.14319 70.85270 70.85270 77.14319
"""

## 직접 구하면 
# Y(학생몸무게) = 32.66 + 0.225 * x(학생의키)
test <- ((32.6604144) + (0.2246605) * (std90$height_cm[1:4]))
test # [1] 77.14319 70.85270 70.85270 77.14319

# 이상값 테스트 -> 'which' must be in 1:6
# 박스 플롯보고싶다
plot(model, which=2)
plot(model, which=4)
plot(model, which=5)
plot(model, which=6)

# 그래프를 보면 3개값이 이상값으로 추측되지만 수치적인 탐색이 수반되어야 할것같다
# 그이후 이상값을 결정할수있을것같다. 

### 이상값 진단
cooks_dist<- cooks.distance(model) ### ** 검색 
cooks_dist[1:4]  # 5.992961e-02 1.202838e-03 2.314356e-05 2.277257e-02


NROW(cooks_dist)  ### ** 검색 


cooks_dist[which(cooks_dist>qf(0.5, df1 = 2, df2 = 88))] # named numeric(0)

# 본페로니 검정 – 설치 및 불러오기
# install.packages("car")
library(car)
outlierTest(model)
"""
No Studentized residuals with Bonferroni p < 0.05
Largest |rstudent|:
   rstudent unadjusted p-value Bonferroni p
90 2.709609          0.0081125      0.73013

# 본페로니 p(=0.73) > 0.05 이상치가 검출 되지 않았다. 
"""

"""
추측과는 다르게 Bonferroni p가 0.05보다 큰 값이 나와 이상치로 검출되지 않았고 
시각화로 찾아낸 이상치 데이터들은
수치가 높을 뿐 이상치라고는 할 수 없다고 본다. 
그렇기 때문때 따로 이상치를 제거하거하는 작업은 
진행하지 않고 다음작업으로 넘어가도록한다
"""
##################################################################################3

## 잔차 구하기 -> 잔차를 구하는 이유는 정규성을 보기 이함이다. 
# 추가 ) 잔차를 구하는이유 : 
# 조건에 따라 편향되지 않고 분산이 일정해야한다. 
# 특정조건에서 잔차가 튀는 것이 없어야 한다. 



# 1~4번째 잔차 : residuals(model)
residuals(model)[1:4] # 20.8568064  6.1473004 -0.8526996 12.8568064

std90$weight_kg[1:4]  # 98 77 70 90

# 실제 데이터 값 = 적합 된 값 + 잔차
fitted(model)[1:4] + residuals(model)[1:4] # 98 77 70 90



### 잔차분석 
# Q-Q plot으로  잔차의 정규성 확인 

## Q-Q plot
qqnorm(residuals(model))
qqline(residuals(model))

## 샤피로 월크 검정을 이용해서 잔차의 정규성확인 
# 샤피로 월크 검정 - 일변수 자료에 대해 수치적으로 정규성을 검정하는 기법 
shapiro.test(residuals(model)) # W = 0.98121, p-value = 0.2189

# 귀무가설 
# 대립가설  

### 회귀 계수의 신뢰구간 구하기 
confint(model, level = 0.95)

"""
                 2.5 %     97.5 %
(Intercept) 4.68512548 60.6357032
height_cm   0.05911794  0.3902031

"""

###  신뢰구간  -> 옵션설정 interval = "confidence"
model_conf <- predict(model, level = 0.95, interval = "confidence")
head(model_conf)

"""
       fit      lwr      upr
1 77.14319 71.45341 82.83298
2 70.85270 68.02003 73.68536
3 70.85270 68.02003 73.68536
4 77.14319 71.45341 82.83298
5 70.85270 68.02003 73.68536
6 69.72940 66.86626 72.59253
"""


## 주어진 키에 대한 평균 몸무게의 95% 신뢰구간 과 산포도
## 추정된 평균 몸무게를 그린 예시

### 키와 몸무게 산포도, 추정된 평균 몸무게, 신뢰구간
plot(weight_kg~height_cm, data = std_cnt_92)
lwr <- model_conf[,2]
upr <- model_conf[,3]

sx <- sort(std_cnt_92$height_cm, index.return=TRUE)
abline(coef(model), lwd=2)
lines(sx$x, lwr[sx$ix],col="blue" , lty=2)
lines(sx$x, upr[sx$ix],col="blue" , lty=2)


### 예측하기 

model_pred <- predict(model, level=0.95, interval="predict")
head(model_pred)

"""
       fit      lwr       upr
1 77.14319 49.83131 104.45507
2 70.85270 43.99029  97.71511
3 70.85270 43.99029  97.71511
4 77.14319 49.83131 104.45507
5 70.85270 43.99029  97.71511
6 69.72940 42.86376  96.59504

"""

# 예측구간 
## 키와 몸무게 산포도, 예측구간 

p_lwr <- model_pred[,2]
p_upr <- model_pred[,3]

# abline(coef(model), lwd=2)
lines(std_cnt_92$height_cm, p_lwr, col="red", lty=2)
lines(std_cnt_92$height_cm, p_upr, col="red", lty=2)

######################################################################


## 잔차 제곱의 합 
deviance(model)  # 15899.88

## 예측 - 2 
## 새로운 학생의 키가 175 cm 이 학생의 예상되는 몸무게 구하기 

predict(model, newdata = data.frame(height_cm=175), interval="confidence")
"""
     fit      lwr      upr
1 71.976 68.93945 75.01255
"""

# 모델평가 
summary(model)

"""
Residuals:
    Min      1Q  Median      3Q     Max
-30.020  -8.460  -1.066   6.918  34.654

Coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept)  32.6604    14.0771   2.320  0.02265 *
height_cm     0.2247     0.0833   2.697  0.00838 **
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 13.44 on 88 degrees of freedom
Multiple R-squared:  0.07635,   Adjusted R-squared:  0.06585 
F-statistic: 7.274 on 1 and 88 DF,  p-value: 0.008385

"""

### 예측 3
(model_a_pre <- lm(weight_kg ~ height_cm, data = std_cnt_92))

"""
Coefficients:
(Intercept)    height_cm
    32.6604       0.2247
"""
(model_b_pre <- lm(weight_kg ~ 1, data = std_cnt_92))

"""
Coefficients:
(Intercept)
      70.43
"""

### 분산 분석 및 모델간의 비교
anova(model_a_pre, model_b_pre)

"""
Analysis of Variance Table

Model 1: weight_kg ~ height_cm
Model 2: weight_kg ~ 1
  Res.Df   RSS Df Sum of Sq      F   Pr(>F)
1     88 15900
2     89 17214 -1   -1314.2 7.2737 0.008385 **
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
"""

### RMSE, MAE를 이용한 모델 비교 
# install.packages("modelr")
library(modelr)

rmse(model_a_pre, std_cnt_92) # 13.29155
mse(model_a_pre, std_cnt_92)  # 176.6653
rmse(model_b_pre, std_cnt_92) # 13.82996
mse(model_b_pre, std_cnt_92)  # 191.2678