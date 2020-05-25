# ESC20SPRING_team4
ESC 20 SPRING team 4 Final Project

서론
=============

0.조원소개
-------------
김민회 남승지 신예진 오태환 조민주 주일찬

1.도입(데이터 설명)
-------------
* 독립변수 64개
  * (ppt수정필요) ppt에 독립변수 설명 빼먹음.. 
* 파산기업 1/ 정상기업 0
* NA 개수

Preprocessing
=============

2.설명변수 선택
-------------
* correlation이 높은 변수 제거(0.7): 28개 남음
  * X1, X5, X6, X9, X10, X15, X17, X18, X19, X20, X21, X26, X27, X29, X41, X42, X45, X46, X47, X54, X55, X57, X59, X60, X61, X63, X64
* ppt에 correlation 그래프 삽입

3.NA Imputation
-------------
* NA가 자료의 약 50%인 37번 변수 제거
* NA Imputation 방법: R mice package를 사용한 pmm(predictive mean matching)
  * MICE 패키지는 MI(multipe imputation) 방식으로 미싱 데이터를 채워넣는 방식이다. Monte Carlo 방법을 통해 채워놓은 n개의 complete dataset을 만들고 그 결과를 합쳐 최종 결과물을 내놓는다. 
  * (ppt수정필요) 총 4단계가 반복됨을 설명해주기
* Imputation 후 correlation이 갑자기 높아진 항목들(이 중 0.9보다 corr 높아진 9&63 제거)
  * 17&46: 0.8149136, 54&64: 0.7010404, 9&63: 0.9309192
  * (ppt수정필요) 이 부분 빼먹음

4.Skewed된 자료 처리
-------------
* 64개 변수 거의 다 skewed to the left
* 따라서 전체 log transformation
* log transformation 전/후 비교 그래프 삽입 -> 많이 좋아졌음을 보여주기
  * (ppt 수정 필요) 그래프 고르는 중

5.Scaling
-------------
* MinMaxScaler 이용
* 모든 데이터는 x축의 0과 1 사이에, y축의 0과 1사이에 위치

6.Outlier 제거
-------------
* outlier의 제거는 곧 데이터의 제거, 최대한 덜 삭제하자
* outlier가 공통적인 data 조사
* outlier 기준: 각 변수에서 가장 작은/큰 값 3개
* 세 개 이상의 X항목에서 outlier를 가지는 회사 총 10개(class 모두 0)
  * (R기준 표기)
  * 6818 is in : 'Attr17', 'Attr18', 'Attr29', 'Attr42', 'Attr46', 'Attr47'
  * 1594 is in : 'Attr21', 'Attr42', 'Attr61', 'Attr63', 'Attr64'
  * 2100 is in : 'Attr17', 'Attr19', 'Attr26', 'Attr46'
  * 4680 is in : 'Attr17', 'Attr26', 'Attr46', 'Attr63'
  * 4995 is in : 'Attr18', 'Attr29', 'Attr60', 'Attr63'
  * 2556 is in : 'Attr19', 'Attr42', 'Attr60'
  * 4120 is in : 'Attr5', 'Attr45', 'Attr60'
  * 5305 is in : 'Attr19', 'Attr21', 'Attr45'
  * 5936 is in : 'Attr10', 'Attr19', 'Attr42'
  * 5811 is in : 'Attr19', 'Attr26', 'Attr42'
* X항목에서 0으로 outlier가 되는 회사 데이터 제거
  * Attr5: 999, Attr6: 3134, Attr15: 3528, Attr19: 2556, Attr26: 2655, Attr41: 6425, Attr42: 2556, Attr45: 6233, Attr54: 4942, Attr55: 4612, Attr57: 1935, Attr59: 2064
* 총 20개의 회사 데이터 제거
  * 999,3134,3528,2556,2655,6425,6233,4942,4612,1935,2064,6818,1594,2100,4680,4995,4120,5305,5936,5811

 7.다시 Scaling
-------------
(ppt수정필요) 승지님이 만드시는 중


Feature Extraction
=============

8.Feature Extraction할 변수 선택 (진행 중)
-------------
* X1 & X17 (ROI)
  * ROI(Return on investment): a profitability measure, 한 회사의 수익성을 판단하는 지표
  * 방법: dividing net income(=net profit) by total liabilities
  * 이게 ROI의 정의는 아니고, ROI를 계산하는 다양한 방법이 있는데 그중 하나라고 합니다!
  * X1 = net profit/total asset, X17 = total assets/total liabilities
  * X1 * X17 = net profit/total liabilities
* X42 & X60
  * X42 = profit on operating activities / sales
    * sales: 매출액
    * profit on operating activities: 영업활동(순이익의 결정에 영향을 미치는 모든 거래)으로부터 얻는 이익
    * X42는 매출액 중 영업활동으로부터 얻는 실제 이익이 얼마나 되는지를 보여주는 지표
  * X60 = sales / inventory
    * inventory(재고자산): 유동자산 중 판매, 생산을 목적으로 보유한 재화로 판매과정을 통해 현금화할 수 있는 자산
    * X60은 재고자산이 실제 매출액으로 얼마나 이어지는지를 보여주는 지표
  * X42 * X60 = profit on operating activities / inventory
    * 재고자산을 고려해 회사가 영업활동으로부터 얼마나 많은 이윤을 남기는지 보여주어 42, 60의 지표를 모두 반영
  
  
Visualization
=============

결론
=============
* 다음주 과정 진행사항 설명해주기
  * 마지막에 만들어진 데이터를 바탕으로 Prototype Model(logistic regression, random forest, xgboost 사용)을 만들어봤는데 Catboost에서 AUROC, F1 score가 가장 높게 나왔다. 하지만 AUROC가 대략 0.69로 아직 만족할 수준이 아니라 좀 더 향상된 모델을 만들 예정이다. 그 방법으로 PCA, FA, 파생변수 추가 등을 계획하고 있다.
