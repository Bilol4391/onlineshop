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

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Product> favouriteProducts = [];

  @override
  void initState() {
    super.initState();
    loadFavouriteProducts();
  }

  Future<void> loadFavouriteProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favouriteItems = prefs.getStringList('favourite_items') ?? [];

    for (String productId in favouriteItems) {
      String? productJson = prefs.getString('product_$productId');
      if (productJson != null) {
        Product product = Product.fromJson(jsonDecode(productJson));
        favouriteProducts.add(product);
      }
    }

    setState(() {});
  }

  void clearFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('favourite_items'); // Remove the favourite items key
    favouriteProducts.clear();

    // ignore: use_build_context_synchronously
    FavouriteProvider favouriteProvider =
    Provider.of<FavouriteProvider>(context, listen: false);
    favouriteProvider.clearFavorites();

    setState(() {});
  }

  void deleteFavourite(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove the product from the list
    favouriteProducts.removeAt(index);

    // Update the favourite items in SharedPreferences
    List<String> favouriteItems =
    favouriteProducts.map((product) => product.id.toString()).toList();
    prefs.setStringList('favourite_items', favouriteItems);

    // Notify listeners that the favourite content has changed
    // ignore: use_build_context_synchronously
    FavouriteProvider favouriteProvider =
    Provider.of<FavouriteProvider>(context, listen: false);
    favouriteProvider.decrementFavoriteItemCount();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;

    if (favouriteProducts.isEmpty) {
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
        title: const Text('Favorite'),
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
                color: themeMode == ThemeMode.dark
                    ? const Color(0xffFFFFFF)
                    : const Color(0xff323232),
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
                'Favorite Items:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: favouriteProducts.length,
                  itemBuilder: (context, index) {
                    Product product = favouriteProducts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 11),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.r)),
                            border: Border.all(
                                color: themeMode == ThemeMode.dark
                                    ? const Color(0xffFFFFFF)
                                    : Colors.grey),
                          ),
                          child: Row(
                            children: [
                              17.r.horizontalSpace,
                              SizedBox(
                                  width: 60.w,
                                  height: 116.h,
                                  child: Image.network(product.image)),
                              20.r.horizontalSpace,
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 15.0),
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
                                          color: themeMode == ThemeMode.dark
                                              ? const Color(0xffFFFFFF)
                                              : Colors.black,
                                        ),
                                        maxLines: 2,
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
                                            color: themeMode == ThemeMode.dark
                                                ? const Color(0xffFFFFFF)
                                                : Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${product.price.toString()}\$",
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
                                    8.verticalSpace,
                                    Row(
                                      children: [
                                        Text(
                                          "${(product.price * 0.8).toStringAsFixed(2)}\$",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: themeMode == ThemeMode.dark
                                                ? const Color(0xffFFFFFF)
                                                : Colors.grey.withOpacity(0.4),
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
                                            color: themeMode == ThemeMode.dark
                                                ? const Color(0xffFFFFFF)
                                                : Colors.black,
                                          ),
                                        ),
                                        80.r.horizontalSpace,
                                        GestureDetector(
                                          onTap: () {
                                            showDeleteProductConfirmationDialog(
                                                index);
                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            color: themeMode == ThemeMode.dark
                                                ? const Color(0xffFFFFFF)
                                                : const Color(0xff323232),
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
                  },
                ),
              ),
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
            content: const Text(
                'Are you sure you want to delete all products from the cart?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  clearFavourite(); // Clear the cart
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
            content: const Text(
                'Are you sure you want to delete all products from the cart?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  clearFavourite(); // Clear the cart
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
            title: const Text('Remove from Favorite?'),
            content: const Text(
                'Are you sure you want to remove the product from the cart?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  deleteFavourite(index); // Delete the product
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
            content: const Text(
                'Are you sure you want to delete the product from the cart?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  deleteFavourite(index); // Delete the product
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
}
