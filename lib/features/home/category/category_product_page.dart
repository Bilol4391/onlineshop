import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:onlineshop/presentation/widgets/badge_component.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/product_model.dart';
import '../../../core/provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../../core/services/api_service.dart';
import '../favourite_page/favourite_page.dart';
import '../product_details/product_details.dart';

class CategoryProductPage extends StatefulWidget {
  final String selectedCategory;

  const CategoryProductPage({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  _CategoryProductPageState createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  late Future<List<Map<String, dynamic>>> products;
  final ApiService apiService = ApiService();
  late Future<Product> product;

  @override
  void initState() {
    super.initState();
    products = fetchProducts();

    products.then((value) {
      for (var product in value) {
        favoriteStatus[product['id']] = false;
      }
    });
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> productList = json.decode(response.body);
        final List<Map<String, dynamic>> filteredProducts = productList
            .where((product) =>
                product is Map<String, dynamic> &&
                product['category'] == widget.selectedCategory)
            .cast<Map<String, dynamic>>()
            .toList();
        return filteredProducts;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void addToCart(int productId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve the existing cart items from local storage
      List<String>? cartItems = prefs.getStringList('cart_items') ?? [];

      // Add the current product ID to the cart items
      cartItems.add(productId.toString());
      prefs.setStringList('cart_items', cartItems);

      CartProvider cartProvider =
          // ignore: use_build_context_synchronously
          Provider.of<CartProvider>(context, listen: false);
      cartProvider.incrementCartItemCount();
      ApiService apiService = ApiService();

      Product productDetails = await apiService.getProduct(productId);
      Map<String, dynamic> productMap = productDetails.toJson();
      String productJson = jsonEncode(productMap);
      prefs.setString('product_$productId', productJson);
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  void addToFavourites(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the existing favourite items from local storage
    List<String>? favouriteProducts =
        prefs.getStringList('favourite_items') ?? [];

    // Add the current product ID to the favourite items
    favouriteProducts.add(productId.toString());
    prefs.setStringList('favourite_items', favouriteProducts);

    // ignore: use_build_context_synchronously
    FavouriteProvider favouriteProvider =
        Provider.of<FavouriteProvider>(context, listen: false);
    favouriteProvider.incrementFavoriteItemCount();

    ApiService apiService = ApiService();
    Product favouriteDetails = await apiService.getProduct(productId);
    Map<String, dynamic> favouriteProductMap = favouriteDetails.toJson();
    String favouriteProductJson = jsonEncode(favouriteProductMap);
    prefs.setString('product_$productId', favouriteProductJson);
  }

  bool isFavorite = false;
  Map<int, bool> favoriteStatus = {};


  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    final cartProvider = Provider.of<CartProvider>(context);
    FavouriteProvider favouriteProvider =
        Provider.of<FavouriteProvider>(context);
    int itemCount = favouriteProvider.favoriteItemCount;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        widget.selectedCategory.toUpperCase(),
                        style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            color: const Color(0xffF05A28),
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      badges.Badge(
                        position: badges.BadgePosition.topEnd(top: 0, end: 0),
                        badgeAnimation: const badges.BadgeAnimation.slide(),
                        showBadge: itemCount > 0,
                        badgeStyle: const badges.BadgeStyle(
                          badgeColor: Color(
                              0xffE35027), // Replace with your desired badge color
                        ),
                        badgeContent: Text(
                          favouriteProvider.favoriteItemCount.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            size: 27,
                            color: themeMode == ThemeMode.dark
                                ? const Color(0xffFFFFFF)
                                : const Color(0xff323232),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const FavouritePage()));
                          },
                        ),
                      ),
                      SizedBox(width: 7.sp),
                      ShoppingCartBadge(
                        itemCount: cartProvider.cartItemCount,
                      ),
                    ],
                  ),
                ),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 333.0),
                        child: Transform.scale(
                          scale: 1.5,
                          child: const CircularProgressIndicator.adaptive(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final List<Map<String, dynamic>> categoryProducts =
                          snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 10, bottom: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.81,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 240,
                              childAspectRatio: 0.85 / 1.4,
                              crossAxisSpacing: 13,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: categoryProducts.length,
                            itemBuilder: (context, index) {
                              final product = categoryProducts[index];
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
                                              addToFavourites(product['id']);
                                              // Toggle the value of isFavorite

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
                                      child: Image.network(product["image"]),
                                    ),
                                    5.verticalSpace,
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Text(
                                          product["title"],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          "${product["price"].toString()}\$",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 10),
                                        Text(
                                          'Price: ${(product["price"] * 0.8).toStringAsFixed(2)}\$',
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
                                        GestureDetector(
                                          onTap: () {
                                            addToCart(product['id']);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Product added to Cart',
                                                  style: GoogleFonts.inter(
                                                      fontSize: 15.sp),
                                                ),
                                                backgroundColor: themeMode ==
                                                        ThemeMode.dark
                                                    ? const Color(0xffFFFFFF)
                                                    : Colors.black,
                                                duration: const Duration(
                                                    milliseconds: 600),
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.add_shopping_cart,
                                            color: themeMode == ThemeMode.dark
                                                ? const Color(0xffFFFFFF)
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
