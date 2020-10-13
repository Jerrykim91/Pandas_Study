# Reshape_Packaage
<br>

## [Reshape](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/reshape)

- 데이터를 재구성하는 패키지 
- melt(), cast() 
![Reshape](https://i2.wp.com/www.r-statistics.com/wp-content/uploads/2012/01/reshaping-data-using-melt-and-cast.png?resize=825%2C510&ssl=1

<br>
<br>

## Melt 
- Melt는 column을 row로 바꿔주는 함수
- melt의 장점
    : 칼럼이 얼마 없을때 보다 칼럼이 굉장히 많을때나 각 칼럼 값을 변수로 직렬화 하여 데이터를 조작할 때 편리
- `melt(Key=id에 지정, 나머지값들은 Row로 변환)`
- reshape 
    - row를 column으로 변경 

<br>

```r
# example of melt function
library(reshape)
mdata <- melt(mydata, id=c("id","time"))
```

<br>
<br>

## Cast
- melt된 데이터를 원하는대로 조합
- 물결표시 앞쪽은 행으로 사용할 값을 정하는데 여러개일때 +로 연결
- 물결표시 뒤쪽은 열로 사용할 값을 정하고 여러개일때 마찬가지로 +로 연결
- FUN에 함수를 지정하면 왼쪽과 같이 평균값 들을 구할 수 있음

<br>

```r
# cast the melted data
# cast(data, formula, function)
# mdata => melting된 데이터
subjmeans <- cast(mdata, id~variable, mean)
timemeans <- cast(mdata, time~variable, mean)
```