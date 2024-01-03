import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourhome_pre_assignment/models/product_selected.dart';

import '../models/product.dart';

class ShoppingBagController extends GetxController {
  static ShoppingBagController get to => Get.find();

  RxList<ProductSelected> shoppingBag = <ProductSelected>[].obs;
  RxInt totalPrice = 0.obs;
  RxInt deliveryFee = 0.obs;

  void addProduct(Product product) {
    shoppingBag.add(
      ProductSelected(
        product: product,
        count: 1.obs,
      ),
    );
    shoppingBag.refresh();
  }

  void removeProduct(Product product) {
    shoppingBag.removeWhere((element) => element.product == product);
    shoppingBag.refresh();
  }

  void increaseProductCount(Product product) {
    shoppingBag.firstWhere((element) => element.product == product).count.value++;
    shoppingBag.refresh();
  }

  void decreaseProductCount(int index) {
    shoppingBag[index].count.value--;
    shoppingBag.refresh();
  }

  void calculateTotalPrice() {
    int total = 0;
    for(int i = 0; i < shoppingBag.length; i++) {
      total += shoppingBag[i].count.value * shoppingBag[i].product.price;
    }
    totalPrice.value = total;
  }

  void determineDeliveryFee() {
    if(totalPrice.value >= 30000) {
      deliveryFee.value = 0;
    } else if(totalPrice.value == 0){
      deliveryFee.value = 0;
    } else {
      deliveryFee.value = 3000;
    }
  }

  bool isProductInShoppingBag(Product product) {
    for(int i = 0; i < shoppingBag.length; i++) {
      if(shoppingBag[i].product == product) {
        return true;
      }
    }
    return false;
  }

  Future<void> showConfirmItemRemoveDialog(int index) async {
    await Get.dialog(
      AlertDialog(
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        alignment: Alignment.topCenter,
        content: const Text(
            "항목을 삭제하시겠습니까?"
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "취소",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          TextButton(
            onPressed: () async {
              removeProduct(shoppingBag[index].product);
              Get.back();
            },
            child: const Text(
              "삭제",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
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
    ever(shoppingBag, (_) {
      calculateTotalPrice();
      determineDeliveryFee();
    });
    super.onInit();
  }
}
