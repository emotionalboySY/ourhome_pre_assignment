import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourhome_pre_assignment/constants/storage_type.dart';
import 'package:ourhome_pre_assignment/controllers/shopping_bag.dart';

import '../constants/tag.dart';
import '../models/product.dart';

class ProductListController extends GetxController {
  static ProductListController get to => Get.find();

  final shoppingBagController = Get.find<ShoppingBagController>();

  final _products = <Product>[].obs;

  List<Product> get products => _products;

  int getDiscountRate(int index) {
    double rate = 100 - ((_products[index].price / _products[index].beforeDiscountPrice!) * 100);
    return rate.round();
  }

  void setProducts() {
    _products.clear();
    _products.addAll([
      Product(
        id: 1,
        imageSrc: 'assets/images/sggt.jpg',
        title: '진한 사골곰탕 300g',
        desc: '100% 사골로 고은 진한 사골곰탕',
        price: 1590,
        beforeDiscountPrice: 1750,
        storageType: StorageType.normal,
        tags: [],
      ),
      Product(
        id: 2,
        imageSrc: 'assets/images/gcem.jpg',
        title: '아워홈 포차 꼬치어묵 (시원한맛)',
        desc: '국산 꽃게육수를 시원하게 담은 어묵탕',
        price: 3900,
        beforeDiscountPrice: 5580,
        storageType: StorageType.freezer,
        tags: [],
      ),
      Product(
        id: 3,
        imageSrc: 'assets/images/ygj.jpg',
        title: '얼큰한 육개장 300g',
        desc: '직접 솥에서 볶아 더 얼큰하고 맛있는',
        price: 3000,
        beforeDiscountPrice: 3150,
        storageType: StorageType.normal,
        tags: [],
      ),
      Product(
        id: 4,
        imageSrc: 'assets/images/gbt.jpg',
        title: '뼈없는 갈비탕 400g',
        desc: '뼈를 발라내어 먹기 편한 뼈없는 갈비탕',
        price: 5940,
        beforeDiscountPrice: 6600,
        tags: [],
        storageType: StorageType.normal,
      ),
      Product(
          id: 5,
          imageSrc: 'assets/images/ckst.jpg',
          title: '아워홈 치킨스테이크 오리지널 920g (4인분)',
          desc: '겉바속촉 통닭다리살 오븐구이 치킨스테이크',
          price: 17000,
          beforeDiscountPrice: 17900,
          tags: [Tag.best],
          storageType: StorageType.freezer),
      Product(
        id: 6,
        imageSrc: 'assets/images/dgrg.jpg',
        title: '아워홈 들기름김 전장 20g (4gX5매)',
        desc: '전장김, 들기름, 반찬, 간식',
        price: 2280,
        beforeDiscountPrice: 2400,
        tags: [],
        storageType: StorageType.normal,
      ),
      Product(
        id: 7,
        imageSrc: 'assets/images/sggjjr.jpg',
        title: '소고기장조림 200g',
        desc: '장조림, 간편반판, 꽈리고추, 곤약',
        price: 3670,
        tags: [],
        storageType: StorageType.fridge,
      ),
      Product(
        id: 8,
        imageSrc: 'assets/images/dggs.jpg',
        title: '매콤한 칠리 닭가슴살 110g (냉장)',
        desc: '단백질 함량 27g, 매콤한 칠리맛',
        price: 2790,
        beforeDiscountPrice: 2980,
        tags: [],
        storageType: StorageType.fridge,
      ),
    ]);
  }

  Future<void> showConfirmAddShoppingBag(int index) async {
    if(shoppingBagController.isProductInShoppingBag(_products[index])) {
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
    }
    else {
      await Get.dialog(
        AlertDialog(
          elevation: 20.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          alignment: Alignment.topCenter,
          content: const Text(
              "상품을 장바구니에 추가하시겠습니까?"
          ),
          actions: [
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
                shoppingBagController.addProduct(_products[index]);
                Get.back();
                await showResultDialog(contentString: "장바구니에서 상품을 추가했습니다.");
              },
              child: const Text(
                "확인",
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
    }
  }

  Future<void> showResultDialog({
    required String contentString,
}) async {
    await Get.dialog(
      AlertDialog(
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        alignment: Alignment.topCenter,
        content: Text(
            contentString,
        ),
        actions: [
          TextButton(
            onPressed: () { Get.back(); },
            child: const Text(
              "확인",
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
  }

  @override
  void onInit() {
    setProducts();
    super.onInit();
  }
}
