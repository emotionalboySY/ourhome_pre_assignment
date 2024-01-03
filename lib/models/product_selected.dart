import 'package:get/get.dart';
import 'package:ourhome_pre_assignment/models/product.dart';

class ProductSelected {
  Product product;
  RxInt count;

  ProductSelected({
    required this.product,
    required this.count,
  });
}