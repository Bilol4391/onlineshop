import 'package:onlineshop/core/models/category_model.dart';
import 'package:onlineshop/core/models/product_model.dart';

class ProductCategory {
  final List<Product> products;
  final List<Category> categories;

  ProductCategory({required this.products, required this.categories});
}
