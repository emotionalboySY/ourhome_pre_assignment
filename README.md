# 아워홈 2023년 하반기 대졸 신입공채 DT전형 웹개발 파트 사전과제

<br>

## 기술 스택
![Static Badge](https://img.shields.io/badge/3.13.9-grey?style=for-the-badge&label=Flutter&labelColor=02569B&logo=flutter)
![Static Badge](https://img.shields.io/badge/3.1.5-grey?style=for-the-badge&label=Dart&labelColor=0175C2&logo=dart)
![Static Badge](https://img.shields.io/badge/4.2.1-grey?style=for-the-badge&label=Android%20Studio&labelColor=3DDC84)

## 사용한 라이브러리
[![Static Badge](https://img.shields.io/badge/4.6.6-grey?style=for-the-badge&label=Get&labelColor=02569B)](https://pub.dev/packages/get)
[![Static Badge](https://img.shields.io/badge/5.9.0-grey?style=for-the-badge&label=flutter_screenutil&labelColor=02569B)](https://pub.dev/packages/flutter_screenutil)
[![Static Badge](https://img.shields.io/badge/8.1.1-grey?style=for-the-badge&label=extended_image&labelColor=02569B)](https://pub.dev/packages/extended_image)
[![Static Badge](https://img.shields.io/badge/0.19.0-grey?style=for-the-badge&label=intl&labelColor=02569B)](https://pub.dev/packages/intl)

## 요구사항
상품 목록 페이지와 장바구니 페이지를 구현하여야 합니다.

## 화면별 구현 결과
### 1. 상품 목록 페이지
<img src="https://github.com/emotionalboySY/ourhome_pre_assignment/blob/master/%5Bnot_for_project%5Dimages/%EC%83%81%ED%92%88%20%EB%AA%A9%EB%A1%9D%20%ED%99%94%EB%A9%B4.png?raw=true" alt="failed to load"/>
<br>

- 주요 로직
  - 상품 목록에 표시되는 각 상품을 하나의 데이터 모델로 만들어서 사용
    ```dart
    class Product {
      int id;
      String imageSrc;
      String title;
      String desc;
      int price;
      int? beforeDiscountPrice;
      List<Tag> tags;
      StorageType storageType;

      Product({
        required this.id,
        required this.imageSrc,
        required this.title,
        required this.desc,
        required this.price,
        this.beforeDiscountPrice,
        required this.tags,
        required this.storageType,
      });
    }
    ```
    - 이 데이터 모델을 활용하여 각 GridView에 표시될 항목을 모듈화 하여 출력하도록 구현
<br>
<br>
### 2. 장바구니 목록 페이지
<img src="https://github.com/emotionalboySY/ourhome_pre_assignment/blob/master/%5Bnot_for_project%5Dimages/%EC%9E%A5%EB%B0%94%EA%B5%AC%EB%8B%88.gif?raw=true" />
<br>

- 주요 로직
  - 장바구니에 포함된 상품의 갯수 조정, 삭제 등의 기능을 구현하기 위해 GetxController 사용
    ```dart
    class ShoppingBagController extends GetxController {
      static ShoppingBagController get to => Get.find();

      RxList<ProductSelected> shoppingBag = <ProductSelected>[].obs;
      RxInt totalPrice = 0.obs;
      RxInt deliveryFee = 0.obs;
    }
    ```
    - Rx 변수를 사용하여 stless한 위젯에서도 GetxController를 통해 실시간 상태 업데이트가 가능하도록 설정
  - 장바구니 정보가 변경될 때마다 총 구매 가격 및 배송비, 결제 금액이 재계산되도록 구현
    ```dart
    @override
    void onInit() {
      ever(shoppingBag, (_) {
        calculateTotalPrice();
        determineDeliveryFee();
      });
      super.onInit();
    }
    ```