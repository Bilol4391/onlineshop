import 'dart:convert';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/product_model.dart';
import '../../../core/provider/provider.dart';
import '../../../presentation/widgets/header_component.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> cartProducts = [];
  double total = 0.0; // Declare the total variable
  int count = 1;

  @override
  void initState() {
    super.initState();
    loadCartProducts();
  }

  Future<void> loadCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cart_items') ?? [];

    for (String productId in cartItems) {
      String? productJson = prefs.getString('product_$productId');
      if (productJson != null) {
        Product product = Product.fromJson(jsonDecode(productJson));
        cartProducts.add(product);

        if (cartProducts.length == 1) {
          total = product.price;
        }
      }
    }

    setState(() {});
  }

  void clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart_items'); // Remove the cart items key
    cartProducts.clear();

    // ignore: use_build_context_synchronously
    CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.clearCart();

    setState(() {});
  }

  void deleteProduct(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove the product from the list
    cartProducts.removeAt(index);

    // Update the cart items in SharedPreferences
    List<String> cartItems = cartProducts.map((product) => product.id.toString()).toList();
    prefs.setStringList('cart_items', cartItems);

    // Notify listeners that the cart content has changed
    CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.decrementCartItemCount();

    setState(() {});
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (Product product in cartProducts) {
      totalPrice += product.price;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;

    if (cartProducts.isEmpty) {
      // If there are no products, display an empty cart message
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SafeArea(
            child: Column(
              children: [
                const HeaderWidget(),
                Center(
                  child: Image.asset("assets/images/emptyCart.png"),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: GestureDetector(
              onTap: () {
                showClearConfirmationDialog();
              },
              child: Icon(
                Icons.clear_outlined,
                size: 27,
                color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cart Items:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    Product product = cartProducts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 11),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.r)),
                            border: Border.all(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey),
                          ),
                          child: Row(
                            children: [
                              17.r.horizontalSpace,
                              SizedBox(
                                  width: 60.w,
                                  height: 116.h,
                                  child: Image.network(product.image)
                              ),
                              20.r.horizontalSpace,
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 220.w,
                                      child: Text(
                                        product.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
                                        ),
                                        maxLines: 2, // Adjust the value based on your requirement
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    5.verticalSpace,
                                    Row(
                                      children: [
                                        Text(
                                          "KRW",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${product.price.toString()}\$",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                    8.verticalSpace,
                                    Row(
                                      children: [
                                        Text(
                                          "${(product.price * 0.8).toStringAsFixed(2)}\$",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey.withOpacity(0.4),
                                            decoration:
                                            TextDecoration.lineThrough,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "-20%",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
                                          ),
                                        ),
                                        80.r.horizontalSpace,
                                        GestureDetector(
                                          onTap: (){
                                            showDeleteProductConfirmationDialog(index);
                                          },
                                          child: Icon(
                                            Icons.remove_shopping_cart,
                                            color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232),
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
                    );
                    //   ListTile(
                    //   title: Text(product.title),
                    //   leading: Image.network(product.image),
                    //   subtitle: Text("${product.price}"),
                    //   trailing: GestureDetector(
                    //     onTap: () {
                    //       showDeleteProductConfirmationDialog(index); // Pass the index of the product
                    //     },
                    //     child: Icon(
                    //       Icons.delete_outline, size: 28,
                    //       color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: GestureDetector(
                  onTap: () {
                    _showCustomDialog(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                        color: const Color(0xffEB6733)
                    ),
                    child: Center(child: Text("Checkout", style: GoogleFonts.inter(fontSize: 17.sp, fontWeight: FontWeight.w600, color: const Color(0xffFFFFFF)),),),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  void showClearConfirmationDialog() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Delete All Products?'),
            content: const Text('Are you sure you want to delete all products from the cart?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  clearCart(); // Clear the cart
                },
                child: const Text('Continue'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete All Products?'),
            content: const Text('Are you sure you want to delete all products from the cart?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  clearCart(); // Clear the cart
                },
                child: const Text('Continue'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

  void showDeleteProductConfirmationDialog(int index) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Delete a Product?'),
            content: const Text('Are you sure you want to delete the product from the cart?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  deleteProduct(index); // Delete the product
                },
                child: const Text('Continue'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete a Product?'),
            content: const Text('Are you sure you want to delete the product from the cart?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  deleteProduct(index); // Delete the product
                },
                child: const Text('Continue'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _showCustomDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildCustomAlertDialog(context);
      },
    );
  }

  Widget _buildCustomAlertDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/cart.png', // Replace with your image path
            width: 120.w,
          ),
          SizedBox(height: 16.h),
          Text(
            'Successfully checkout',
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            clearCart(); // Clear the cart
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
