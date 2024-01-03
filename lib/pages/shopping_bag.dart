import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/shopping_bag.dart';
import '../models/product_selected.dart';

class ShoppingBagPageBuilder extends StatelessWidget {
  ShoppingBagPageBuilder({super.key});

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, viewportConstraints) {
          double screenWidth = MediaQuery.of(context).size.width;
          bool isHorizontalScrollNeeded = screenWidth < 1080.0;

          Widget content = isHorizontalScrollNeeded
              ? Scrollbar(
                  thumbVisibility: true,
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: ShoppingBagPage(),
                  ),
                )
              : ShoppingBagPage();

          return content;
        },
      ),
    );
  }
}

class ShoppingBagPage extends StatelessWidget {
  ShoppingBagPage({super.key});

  final shoppingBagController = Get.put(ShoppingBagController());
  final scrollController = ScrollController();
  final value = NumberFormat("#,##0", "ko_KR");

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Center(
          child: SizedBox(
            width: 1200.0,
            height: 800.0,
            child: Column(
              children: [
                // product list page
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed("/product_list");
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                          shadowColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                          surfaceTintColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                          elevation: MaterialStateProperty.resolveWith((states) => 0.0),
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.5,
                                color: Colors.grey.shade500,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "쇼핑 목록으로 돌아가기",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // shopping bag list header
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    height: 60,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: const Border(
                            left: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            top: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          )),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Center(
                              child: Text("상품명"),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text("구매가"),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text("수량"),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text("금액"),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // shopping bag list content (using Obx)
                Obx(
                  () => Expanded(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          right: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: shoppingBagController.shoppingBag.isNotEmpty
                          ? ListView.builder(
                              itemCount: shoppingBagController.shoppingBag.length,
                              itemBuilder: (context, index) {
                                ProductSelected element = shoppingBagController.shoppingBag[index];
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: ExtendedImage.asset(
                                                      element.product.imageSrc,
                                                      border: Border.all(
                                                        color: Colors.grey.shade300,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  element.product.title,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    letterSpacing: -0.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${value.format(element.product.price)}원",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 15,
                                                      letterSpacing: -0.5,
                                                    ),
                                                  ),
                                                  if (element.product.beforeDiscountPrice != null)
                                                    Text(
                                                      "${value.format(element.product.beforeDiscountPrice)}원",
                                                      style: const TextStyle(
                                                        decoration: TextDecoration.lineThrough,
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 12,
                                                        letterSpacing: -0.5,
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: IconButton(
                                                    onPressed: shoppingBagController.shoppingBag[index].count.value == 1
                                                        ? null
                                                        : () {
                                                            shoppingBagController.decreaseProductCount(index);
                                                          },
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      size: 15.0,
                                                    ),
                                                    style: Theme.of(context).iconButtonTheme.style!.copyWith(
                                                          shape: MaterialStateProperty.resolveWith(
                                                            (states) => RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.zero,
                                                              side: BorderSide(
                                                                color: Colors.grey.shade300,
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                  height: 20,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color: Colors.grey.shade300,
                                                          width: 1.0,
                                                        ),
                                                        bottom: BorderSide(
                                                          color: Colors.grey.shade300,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        element.count.toString(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      shoppingBagController.increaseProductCount(element.product);
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 15.0,
                                                    ),
                                                    style: Theme.of(context).iconButtonTheme.style!.copyWith(
                                                          shape: MaterialStateProperty.resolveWith(
                                                            (states) => RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.zero,
                                                              side: BorderSide(
                                                                color: Colors.grey.shade300,
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Text(
                                                "${value.format(element.product.price * element.count.value)}원",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  letterSpacing: -0.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: IconButton(
                                                onPressed: () async {
                                                  await shoppingBagController.showConfirmItemRemoveDialog(index);
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  size: 30.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 1,
                                      width: double.infinity,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                "장바구니에 담긴 상품이 없습니다.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                // shopping bag list footer (total price, using Obx)
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: const Border(
                      left: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          const Text(
                            "총 금액",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Obx(
                              () => Text(
                                "${value.format(shoppingBagController.totalPrice.value)}원",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Icon(
                          Icons.add,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          const Text(
                            "배송비",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Obx(
                              () => Text(
                                "${value.format(shoppingBagController.deliveryFee.value)}원",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "(3만원 이상 구매 시 무료배송)",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Icon(
                          CupertinoIcons.equal,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          const Text(
                            "결제 금액",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Obx(
                              () => Text(
                                "${value.format(shoppingBagController.totalPrice.value + shoppingBagController.deliveryFee.value)}원",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
