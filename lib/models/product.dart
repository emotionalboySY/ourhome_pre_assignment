import '../constants/storage_type.dart';
import '../constants/tag.dart';

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