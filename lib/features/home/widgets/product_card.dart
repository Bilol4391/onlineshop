import 'dart:convert';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop/core/models/product_model.dart';
import 'package:onlineshop/presentation/widgets/badge_component.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/provider/provider.dart';
import '../../../core/services/api_service.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final ApiService apiService = ApiService();
  late Future<Product> product;

  void addToCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the existing cart items from local storage
    List<String>? cartItems = prefs.getStringList('cart_items') ?? [];

    // Add the current product ID to the cart items
    cartItems.add(widget.product.id.toString());
    prefs.setStringList('cart_items', cartItems);

    // ignore: use_build_context_synchronously
    CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.incrementCartItemCount();

    Product productDetails = await apiService.getProduct(widget.product.id);
    Map<String, dynamic> productMap = productDetails.toJson();
    String productJson = jsonEncode(productMap);
    prefs.setString('product_${widget.product.id}', productJson);
  }

  void addToFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the existing favourite items from local storage
    List<String>? favouriteProducts = prefs.getStringList('favourite_items') ?? [];

    // Add the current product ID to the favourite items
    favouriteProducts.add(widget.product.id.toString());
    prefs.setStringList('favourite_items', favouriteProducts);

    // ignore: use_build_context_synchronously
    FavouriteProvider favouriteProvider = Provider.of<FavouriteProvider>(context, listen: false);
    favouriteProvider.incrementFavoriteItemCount();

    Product favouriteDetails = await apiService.getProduct(widget.product.id);
    Map<String, dynamic> favouriteProductMap = favouriteDetails.toJson();
    String favouriteProductJson = jsonEncode(favouriteProductMap);
    prefs.setString('product_${widget.product.id}', favouriteProductJson);
  }
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    return Container(
      decoration: BoxDecoration(
        color: themeMode == ThemeMode.dark
            ? const Color(0xff151518)
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: themeMode == ThemeMode.dark
              ? const Color(0xffFFFFFF)
              : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 5,
            ),
            child: Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    addToFavourites();
                    // Toggle the value of isFavorite
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    // Show a snackbar with a message based on whether the product was added or removed
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isFavorite
                              ? 'Product added to Favourite section'
                              : 'Product removed from Favourite section',
                          style: GoogleFonts.inter(fontSize: 15.sp),
                        ),
                        backgroundColor: themeMode == ThemeMode.dark
                            ? const Color(0xffFFFFFF)
                            : Colors.black,
                        duration: const Duration(milliseconds: 600),
                      ),
                    );
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: themeMode == ThemeMode.dark
                        ? const Color(0xffFFFFFF)
                        : Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 160,
            width: 120,
            child: Image.network(widget.product.image),
          ),
          5.verticalSpace,
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Text(
                widget.product.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: themeMode == ThemeMode.dark
                      ? const Color(0xffFFFFFF)
                      : Colors.black,
                ),
              ),
            ),
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Price:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: themeMode == ThemeMode.dark
                      ? const Color(0xffFFFFFF)
                      : Colors.black,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "${widget.product.price.toString()}\$",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: themeMode == ThemeMode.dark
                      ? const Color(0xffFFFFFF)
                      : Colors.black,
                ),
              )
            ],
          ),
          3.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Text(
                'Price: ${(widget.product.price * 0.8).toStringAsFixed(2)}\$',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: themeMode == ThemeMode.dark
                      ? const Color(0xffFFFFFF)
                      : Colors.grey.withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "-20%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: themeMode == ThemeMode.dark
                      ? const Color(0xffFFFFFF)
                      : Colors.black,
                ),
              ),
              const SizedBox(width: 13),
              InkWell(
                onTap: () {
                  addToCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Product added to Cart', style: GoogleFonts.inter(fontSize: 15.sp),),
                      backgroundColor: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
                      duration: const Duration(milliseconds: 600),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add_shopping_cart,
                  // color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey,
                  color: Color(0xffE35027),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
