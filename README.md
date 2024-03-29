# 아워홈 2023년 하반기 대졸 신입공채 DT전형 웹개발 파트 사전과제

<br>

## 기술 스택
![Static Badge](https://img.shields.io/badge/3.13.9-grey?style=for-the-badge&label=Flutter&labelColor=02569B&logo=flutter)
![Static Badge](https://img.shields.io/badge/3.1.5-grey?style=for-the-badge&label=Dart&labelColor=0175C2&logo=dart)
![Static Badge](https://img.shields.io/badge/4.2.1-grey?style=for-the-badge&label=Android%20Studio&labelColor=3DDC84)

<br>

## 사용한 라이브러리
[![Static Badge](https://img.shields.io/badge/4.6.6-grey?style=for-the-badge&label=Get&labelColor=02569B)](https://pub.dev/packages/get)

[//]: # ([![Static Badge]&#40;https://img.shields.io/badge/5.9.0-grey?style=for-the-badge&label=flutter_screenutil&labelColor=02569B&#41;]&#40;https://pub.dev/packages/flutter_screenutil&#41;)
[![Static Badge](https://img.shields.io/badge/8.1.1-grey?style=for-the-badge&label=extended_image&labelColor=02569B)](https://pub.dev/packages/extended_image)

[![Static Badge](https://img.shields.io/badge/0.19.0-grey?style=for-the-badge&label=intl&labelColor=02569B)](https://pub.dev/packages/intl)

<br>

## 요구사항
상품 목록 페이지와 장바구니 페이지를 구현하여야 합니다.

<br>

## Flutter를 선택한 이유
- 크로스플랫폼이 가능한 유명한 프레임워크이며, 추후 더욱 다양한 회사에서 `Flutter`를 적용할 가능성이 높아지고 있기 때문입니다.
- 정해진 기한 안에 요구하는 사항을 모두 구현하기 위해서입니다.
- 가장 자신 있는 프레임워크가 `Flutter`입니다.
- 약 6개월 간 산학협동인턴십을 통해 `Flutter`를 학습하였으며, 앞으로 제가 맞는 직무에 필요한 적절한 프레임워크를 선택하여 빠르게 적응 및 학습할 수 있음을 보여드리고자 합니다.

<br>

## 화면별 구현 결과
### 1. 상품 목록 페이지
<img src="https://github.com/emotionalboySY/ourhome_pre_assignment/blob/master/%5Bnot_for_project%5Dimages/%EC%83%81%ED%92%88%20%EB%AA%A9%EB%A1%9D%20%ED%99%94%EB%A9%B4.png?raw=true" alt="failed to load"/>
<br>

- 주요 로직
  - 상품 목록에 표시되는 각 상품을 하나의 데이터 모델로 만들어서 사용했습니다.
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
    - 이 데이터 모델을 활용하여 각 `GridView`에 표시될 항목을 모듈화 하여 출력하도록 구현하였습니다.
      ```dart
      GridView.builder(
        padding: const EdgeInsets.only(top: 10.0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 30,
          childAspectRatio: 1 / 2,
        ),
        itemCount: productListController.products.length,
        itemBuilder: (context, index) {
          return productListItem(index);
        },
      )
      ```
  - 각 상품 항목의 **[장바구니]** 버튼을 누르면 관련 팝업창이 뜨며, 처리 여부를 결정할 수 있습니다.
    <img src="https://github.com/emotionalboySY/ourhome_pre_assignment/blob/master/%5Bnot_for_project%5Dimages/%EC%9E%A5%EB%B0%94%EA%B5%AC%EB%8B%88%20%EC%B6%94%EA%B0%80%20%ED%8C%9D%EC%97%85.png?raw=true" />
  
    <img src="https://github.com/emotionalboySY/ourhome_pre_assignment/blob/master/%5Bnot_for_project%5Dimages/%EC%9E%A5%EB%B0%94%EA%B5%AC%EB%8B%88%20%EC%A7%80%EC%9A%B0%EA%B8%B0%20%ED%8C%9D%EC%97%85.png?raw=true"/>
    
    - 팝업창은 `GetxController`의 `Get.dialog`를 활용하였습니다.
    ```dart
    await Get.dialog(
      AlertDialog(
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        alignment: Alignment.topCenter,
        content: const Text(
            "이미 장바구니에 상품이 추가되어 있습니다. 장바구니에 담긴 상품의 갯수를 늘릴까요?"
        ),
        actions: [
          TextButton(
            onPressed: () async {
              shoppingBagController.removeProduct(products[index]);
              Get.back();
              await showResultDialog(contentString: "장바구니에서 상품을 삭제했습니다.");
            },
            child: const Text(
              "장바구니에서 지우기",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "취소",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          TextButton(
            onPressed: () async {
              shoppingBagController.increaseProductCount(products[index]);
              Get.back();
              await showResultDialog(contentString: "장바구니에 담긴 상품의 갯수를 늘렸습니다.");
            },
            child: const Text(
              "추가",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      transitionDuration: Duration.zero,
    );
    ```
    

<br>
    
### 2. 장바구니 목록 페이지
<img src="https://github.com/emotionalboySY/ourhome_pre_assignment/blob/master/%5Bnot_for_project%5Dimages/%EC%9E%A5%EB%B0%94%EA%B5%AC%EB%8B%88.gif?raw=true" />
<br>

- 주요 로직
  - 장바구니에 포함된 상품의 갯수 조정, 삭제 등의 기능을 구현하기 위해 `GetxController`를 사용했습니다.
    ```dart
    class ShoppingBagController extends GetxController {
      static ShoppingBagController get to => Get.find();

      RxList<ProductSelected> shoppingBag = <ProductSelected>[].obs;
      RxInt totalPrice = 0.obs;
      RxInt deliveryFee = 0.obs;
    }
    ```
    - `Rx`변수를 사용하여 `stless`한 위젯에서도 `GetxController`를 통해 실시간 상태 업데이트가 가능하도록 설정했습니다.

  - 장바구니 정보가 변경될 때마다 총 구매 가격 및 배송비, 결제 금액이 재계산되도록 구현했습니다.
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