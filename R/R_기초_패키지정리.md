<br>

#### 번외. R 기초 - R 패키지 정리

<br>

# R 패키지 정리

<br>


## 1. 데이터 로드 

<br>

### 1) `RMySQL, RPostgresSQL, RSLite`

<br>

데이터베이스(DB)로부터 직접 데이터를 읽을 때 사용하는 패키지로     
R[데이터베이스명] `RMySQL`은 `MySQL`의 데이터들을 직접 `R`로 불러올 수 있다. 

<br>

```R
# RMySQL
install.packages("RMySQL") # 설치
library(RMySQL)  # 패키지 불러오기

# `dbConnect()` 함수는 `MySQL` DB로 연결한한다. 

con <- dbConnect(
  MySQL(),
  user = 'uid',
  password = 'pwd',
  host = '127.0.0.1', # hostname
  dbname = 'test-db' # 연결할 db이름
)
dbSendQuery(con, 'set character set "utf8"') # utf8 지정 
```

<br>

### 2) `XLConnect, xlsx`

<br>

MS사의 엑셀을 R로 직접적으로 읽고 쓰게 가능하다. 

<br>

```R
# :: 불러오기
# XLConnect
install.packages("XLConnect") # 설치
library(XLConnect)  # 패키지 불러오기
#  2003이하 버전, 2007이상 버전 모두 read 가능하다. 
wb <- XLConnect::loadWorkbook("파일명.xlsx") # 미리 정의 된 Excel 셀 스타일을 자동으로 가지고옴
sheet1 <- XLConnect::readWorksheet(wb, "Sheet1")
```

<br>

### 3) `foreign`

<br>

- `SAS`, `SPSS` 데이터셋을 읽어올때 사용한다
    - `SAS`의 경우 `sas 7bdat` 확장자로 되어있는 파일인데 읽어올 때 `foreign` 패키지를 사용해서 읽어올 수 있다. 

- CRAN에서 삭제가 되었다. 그렇기 때문에 R의 `install.packges()` 함수에 패키지명을 입력하는 방식으로는 설치가 불가능하다. 번거롭지만 수동으로 설치 해야한다. 
  1) `foreign` 패키지 설치 url : <https://cran.r-project.org/src/contrib/Archive/foreign/>
  2) 원하는 파일명 혹은 버전을 받아 설치 -> 파일타입 : 압축파일(.gz)
  3) R을 열고 아래와 같이 작성한 후 실행하면 설치가 완료된다.

      ```R
      install.packages("https://cran.r-project.org/src/contrib/Archive/패키지명/원하는 버전 파일명.tar.gz", repos = NULL, type="source") 

      ## 예를 들면 
      # 패키지 설치
      install.packages("https://cran.r-project.org/src/contrib/Archive/foreign/foreign_0.8-79.tar.gz", repos = NULL, type="source") 

      # 불러오기
      library(foreign) 
      ```

<br>

### 4) 일반적인 텍스트 파일을 로드할 때

<br>

- R 에서는 별다른 패키지가 필요하지 않다.         
  - `read.csv`, `read.table,` `read.fwf`를 이용하면 된다.
<!-- 이외의 독특한 자신만의 데이터셋을 불러오고 싶다면 CRAN guide에 데이터 `import`, `export`에 관해 문의가능하다.   -->

<br><br>

## 2. 데이터 핸들링 

<br>

데이터 핸들링은 데이터 분석할 때 가장 중요한 작업 중 하나이다.      
분석을 하기 위해서는 데이터를 올바르게 정제하고 다룰 줄 알아야 한다. 그래야 올바른 분석이 가능하다. 

<br>

### 1) `dplyr`

<br>

- 데이터 처리에 특화된 R 패키지이다. `plyr`도 특화되어있지만 모든 함수가 R로 작성되어서 처리속도가 느리다. 
- `dplyr` 는 빠른 핸들링을 위하여 반드시 사용하는 패키지이다. 
  - C++로 작성되어 불필요한 함수를 호출하지 않는다.
- `dplyr` 의 장점은 파이프 연산자(`%>%`)를 사용해서 함수 다수를 조합한다는 것이다. 
  - 개인적으로 좀 더 직관적인것 같아서 선호한다. 

<br>

```R
# 패키지 설치
install.packages('dplyr')

# 불러오기
library(dplyr)
```

<br>

- dplyr 패키지 관련 예제 &nbsp;: &nbsp; <https://statkclee.github.io/r-gapminder-kr/13-dplyr/index.html>

---

<br>

#### **활용도가 높은 함수**

<br>

1. `select()` : 데이터프레임에서 컬럼을 추출해서 작업한다. (열의 추출)
2. `filter()` : 지정한 조건에 따라 행(row)을 추출한다. 
    - 주의할점은 연산순서에 따라 결과가 달라진다.
3. `group_by()` : 데이터에서 특정 컬럼을 지정해서 그룹 별로 묶을 수 있다. `select()`와 다른점은 그룹이냐 아니냐 인것같다. 
4. `summarize()` : 요약함수로서 `mean()`, `sd()`, `var()`, `median()` 등의 함수를 지정하여 기초 통계량을 보여준다. 
5. `mutate()` : 기존 칼럼값을 활용하여 새로운 칼럼을 생성할때, 파생변수를 만들거나 기존 변수를 변환할 때 사용한다.
6. `arrange()` : 작은 값으로부터 큰 값의 순으로 데이터를 정렬 할 때 사용한다. -> 열지정

<br>

---

- 데이터 `subsetting`, `summarizing`, `rearranging`, `joining`에 대한 더 쉬운 길을 제공한다. 


<br>

### 2) `tidyr`

<br>

- `tidyr` = 깔끔한 데이터 
- 주로 `dplyr`와 같이 사용된다. 
- `tidyr`는 데이터셋의 레이아웃을 바꿀 때 유용한 툴이다. 
    - 데이터를 `tidt format`으로 바꾸기 위해 `gather` 이나 `spread` 함수를 사용가능하다. 
<br>

```R
# 패키지 설치
install.packages('tidyr')

# 불러오기
library(tidyr)
```
- tidyr 패키지 관련 세부설명 &nbsp;: &nbsp; <https://gomguard.tistory.com/229>

<br>

### 3) `stringr`

<br>

- `stringr`는 문자열 다루는 것과 정규표현식 관련된 패키지이다. 
- `stringr` 패키지는 `tidyverse` 패키지에 속해있다. 그래서 미리 설치해 둔 `tidyverse` 패키지가 있다면 불러와 사용가능하다. 

<br>

```R
# 패키지 설치
install.packages('stringr')

# 불러오기
library(stringr)
```

- stringr 패키지 관련 세부설명 &nbsp;: &nbsp; <https://gomguard.tistory.com/231?category=733745>
- stringr 패키지 관련 예제 &nbsp;: &nbsp; <https://aworklab.tistory.com/10>

<br>

### 4) `lubridate`

<br>

- date와 time을 다루기 쉽게 만드는 툴이다. 

```R
# 패키지 설치
install.packages('lubridate')

# 불러오기
library(lubridate)
```
- lubridate 패키지 관련 예제 &nbsp;: &nbsp; <https://kuduz.tistory.com/1201>

<br><br>


## 3. 데이터 시각화 

<br>

### 1) `ggplot2`

<br>

- R에서 매우 유명한 시각화 패키지로 grammar of graphics를 활용하여 layered, customizable plot을 만들 수 있다는 장점이 있다. 
- `ggplot2`은 함수가 직관적이고, 그래픽 시스템의 완성도가 높다. 
- 복잡성 높은 시각화 산출물을 단계별 접근법을 통해 생성 그리고 레이어를 통해 좀더 직관적인 그래프를 사용자에게 보여줄 수 있다. 

```R
# 패키지 설치
install.packages('ggplot2')

# 불러오기
library(ggplot2)
```
- ggplot2 패키지 관련 예제 &nbsp;: &nbsp; <https://statkclee.github.io/R-ecology-lesson/kr/05-visualization-ggplot2.html>

<br>

### 2) `ggvis`

<br>

- grammar of graphics 기반으로 동작하는, 대화형 웹베이스 그래픽 라이브러리이다.
- ggvis = 웹브라우져 기능 + ggplot
- ggvis 패키지 관련 예제 &nbsp;: &nbsp; <https://statkclee.github.io/viz/viz-ggvis.html>

<br>

### 3) `rgl`

<br>

- 3D 시각화를 위한 라이브러리이다. 

```R
# 패키지 설치
install.packages('rgl')

# 불러오기
library(rgl)
```

<br>

### 4) `htmlwidgets`

<br>

- 자바스크립트 기반의 시각화를 위한 툴이다. 
- htmlwidgets 홈페이지 &nbsp;: &nbsp; <https://www.htmlwidgets.org/>

<br>

### 5) `googleVis`

<br>

- `R` 에서 데이터 시각화를 위해 구글 차트를 이용 할 수 있게 한다.
- 구글 차트 툴은 `Gapminder` 라고 불린다.


```R
# 패키지 설치
install.packages('googleVis')

# 불러오기
library(googleVis)
```

<br><br>

<!-- 
### 4) 데이터 모델링 

<br>

### 1) `car`

<br>

- car 패키지의 Anova 함수는 type2, type3 아노바 테이블을 만드는데 유명하다. 

<br>

### 2) `mgcv`

<br>

<br>

### 3) `lme4 / nlme`

<br>

- 라이너 , 논 라이너 혼합효과모형

<br>

### 4) `randomForest`

<br>

- 머신러닝의 렌덤포레스트 

<br>

### 5) `multcomp`

<br>

- 다중비교를 위한 툴 

<br>

### 6) `vcd`

<br>

- 범주형 변수의 시각화 분석을 위한 툴 

<br>

### 7) `glmnet`

<br>

- Lasso, elastic-net 회귀분석을 cross validation과 함깨 해준다. 

<br>

### 8) `survival`

<br>

- 생존분석

<br>

### 9) `caret`

<br>

- 회귀분석 및 분류 모델의 트레이닝을 위한 툴이다. 

<br> -->

<br>

---

<br>

## Reference <br>

- R VScode install  &nbsp; : &nbsp;<https://ark1st.tistory.com/7> <br>
- 데이터 과학  &nbsp; : &nbsp;<https://statkclee.github.io/data-science/data-science-library.html><br>


<br>
<br>

## Practice makes perfect! <br>

<!-- - [내용](주소) -->