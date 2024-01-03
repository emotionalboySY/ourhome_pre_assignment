import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_image/extended_image.dart';
import 'package:intl/intl.dart';

import 'package:ourhome_pre_assignment/controllers/product_list.dart';

import '../constants/storage_type.dart';

class ProductListPageBuilder extends StatelessWidget {
  ProductListPageBuilder({super.key});

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
                    child: ProductListPage(),
                  ),
                )
              : ProductListPage();

          return content;
        },
      ),
    );
  }
}

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final productListController = Get.find<ProductListController>();

  final value = NumberFormat("#,##0", "ko_KR");
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Center(
          child: SizedBox(
            width: 1200.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed("/shopping_bag");
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
                            "장바구니",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget productListItem(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // id
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              (index + 1).toString().padLeft(2, "0"),
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        // image
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AspectRatio(
            aspectRatio: 1,
            child: ExtendedImage.asset(
              productListController.products[index].imageSrc,
              border: Border.all(
                color: Colors.grey.shade300,
                width: 0.5,
              ),
            ),
          ),
        ),
        // tags(if exists)
        if (productListController.products[index].tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 5,
              children: productListController.products[index].tags.map((element) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: element.color,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
                    child: Text(
                      element.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        // title
        Text(
          productListController.products[index].title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        // description
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            productListController.products[index].desc,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        // price(if discounted, also include original price
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  "${value.format(productListController.products[index].price)}원",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              if (productListController.products[index].beforeDiscountPrice != null)
                Text(
                  "${value.format(productListController.products[index].beforeDiscountPrice)}원 ",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              if (productListController.products[index].beforeDiscountPrice != null)
                Text(
                  "${productListController.getDiscountRate(index).toString()}%",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        // storage type
        Text(
          productListController.products[index].storageType.name,
          style: TextStyle(
            color: productListController.products[index].storageType == StorageType.normal ? Colors.black : Colors.blue,
            fontSize: 13,
          ),
        ),
        // buy, shopping bag buttons
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: productListItemButtons(index),
        ),
      ],
    );
  }

  Widget productListItemButtons(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey.shade300,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(0.0),
              ),
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              disabledBackgroundColor: Colors.white,
            ),
            child: const Center(
              child: Text(
                "구매하기",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: ElevatedButton(
              onPressed: () async {
                await productListController.showConfirmAddShoppingBag(index);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey.shade300,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                backgroundColor: Colors.white,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                surfaceTintColor: Colors.white,
              ),
              child: const Center(
                child: Text(
                  "장바구니",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
