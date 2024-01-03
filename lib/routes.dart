import 'package:get/get.dart';
import 'package:ourhome_pre_assignment/pages/product_list.dart';
import 'package:ourhome_pre_assignment/pages/shopping_bag.dart';

List<GetPage> route = [
  GetPage(
    name: '/product_list',
    page: () => ProductListPageBuilder(),
  ),
  GetPage(
    name: '/shopping_bag',
    page: () => ShoppingBagPageBuilder(),
  ),
];