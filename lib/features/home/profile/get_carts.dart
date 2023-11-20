import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:onlineshop/presentation/widgets/header_component.dart';
import 'package:onlineshop/presentation/widgets/loading_component.dart';

class Cart {
  final int id;
  final int userId;
  final String date;
  final List<ProductCart> products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonProducts = json['products'];
    List<ProductCart> products = jsonProducts.map((product) => ProductCart.fromJson(product)).toList();

    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: products,
    );
  }
}

class ProductCart {
  final int productId;
  final int quantity;

  ProductCart({
    required this.productId,
    required this.quantity,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) {
    return ProductCart(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  late Future<List<Cart>> carts;

  String _formatDate(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    carts = fetchCarts();
  }

  Future<List<Cart>> fetchCarts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/carts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((cart) => Cart.fromJson(cart)).toList();
    } else {
      throw Exception('Failed to load carts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderWidget(),
            12.r.verticalSpace,
            FutureBuilder<List<Cart>>(
              future: carts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Cart> cartList = snapshot.data!;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.82,
                    child: ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        Cart cart = cartList[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12),
                          child: ExpansionTile(
                            title: Text('Cart ${cart.id}'),
                            children: [
                              ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('User ID: ${cart.userId}'),
                                    8.r.verticalSpace,
                                    Text('Date: ${_formatDate(cart.date)}'),
                                    8.r.verticalSpace,
                                    const Text('Products:'),
                                    ...cart.products.map(
                                          (product) => Padding(
                                        padding: const EdgeInsets.only(left: 16.0, top: 8),
                                        child: Text(
                                          'Product ID: ${product.productId},   Quantity: ${product.quantity}',
                                        ),
                                      ),
                                    ),
                                    17.r.verticalSpace,
                                  ],
                                ),
                                onTap: () {
                                  // Handle tap event if needed
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
