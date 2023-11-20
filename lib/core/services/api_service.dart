// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onlineshop/core/models/category_product_model.dart';
import 'package:onlineshop/core/models/category_model.dart';
import 'package:onlineshop/core/models/product_model.dart';

class ApiService {
  //
  Future<ProductCategory> getProductsAndCategories() async {
    final List<Product> products = await getProducts();
    final List<Category> categories = await getCategories();

    return ProductCategory(products: products, categories: categories);
  }


  Future<Product> getProduct(int productId) async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$productId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return Product.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/category/$category'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }
}
