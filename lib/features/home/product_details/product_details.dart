import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop/core/models/product_model.dart';
import 'package:onlineshop/core/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cart/cart_page.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

int _currentIndex = 0;
List listOfNetworkImage = [
  "assets/images/discount_1.png",
  "assets/images/discount_2.png",
  "assets/images/discount_3.png"
];

int starfor = 0;

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int count = 1;
  late Future<Product> product;
  final ApiService apiService = ApiService();

  void incrementCount() {
    setState(() {
      count++;
    });
  }

  void decrementCount() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  void addToCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the existing cart items from local storage
    List<String>? cartItems = prefs.getStringList('cart_items') ?? [];

    // Add the current product ID to the cart items
    cartItems.add(widget.productId.toString());

    // Save the updated cart items back to local storage
    prefs.setStringList('cart_items', cartItems);

    // Retrieve the product details from the API
    Product productDetails = await apiService.getProduct(widget.productId);

    // Save the product details using the product ID as the key
    // Note: Convert the Product object to a Map
    Map<String, dynamic> productMap = productDetails.toJson();

    // Convert the Map to a JSON string
    String productJson = jsonEncode(productMap);

    // Save the product details using the product ID as the key
    prefs.setString('product_${widget.productId}', productJson);

    // Optionally, you can show a confirmation message or navigate to the cart page.
    // For example:
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Product added to cart')));
  }



  @override
  void initState() {
    super.initState();
    product = apiService.getProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 10.sp),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 140.w,
                      height: 27,
                      child: Image.asset("assets/icons/storelingLogo.png"),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.search,
                      color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232),
                      size: 27.sp,
                    ),
                    SizedBox(width: 7.sp),
                    Icon(
                      Icons.favorite_outline_rounded,
                      color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232),
                      size: 27.sp,
                    ),
                  ],
                ),
              ),
              30.r.verticalSpace,
              FutureBuilder<Product>(
                future: product,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 260.0),
                      child: Transform.scale(
                        scale: 1.5,
                        child: const CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    Product product = snapshot.data!;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.72,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 220.h,
                              width: double.infinity,
                              child: PageView.builder(
                                itemCount: 1,
                                itemBuilder: (context, pagePosition) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Swiper(
                                      loop: false,
                                      index: _currentIndex,
                                      onIndexChanged: (index) {
                                        setState(() {
                                          _currentIndex = index;
                                        });
                                      },
                                      pagination: const SwiperPagination(
                                        alignment: Alignment.bottomCenter,
                                        builder: DotSwiperPaginationBuilder(
                                          color: Color(0xffffffff),
                                          activeColor: Color(0xffEB6733),
                                          space: 4,
                                        ),
                                      ),
                                      itemCount: listOfNetworkImage.length,
                                      itemBuilder: (BuildContext context, int index1) {
                                        return Image.network(
                                          product.image,
                                          fit: BoxFit.contain,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            8.r.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Divider(
                                color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey,
                              ),
                            ),
                            8.r.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 15),
                              child: Text(
                                product.title,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp,
                                  color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                                ),
                              ),
                            ),
                            12.r.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Category: ${product.category.toUpperCase()}",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.sp,
                                  color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                                ),
                              ),
                            ),
                            12.r.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Text(
                                "About:",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.sp,
                                  color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                                ),
                              ),
                            ),
                            7.r.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 20),
                              child: Text(
                                product.description,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.sp,
                                  color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                                ),
                              ),
                            ),
                            8.r.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Divider(
                                color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey,
                              ),
                            ),
                            10.r.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Text(
                                    "Price",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.sp,
                                      color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                                    ),
                                  ),
                                  7.r.horizontalSpace,
                                  Text(
                                    '${product.price.toString()}\$',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                      color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: decrementCount,
                                    child: Container(
                                      width: 25.w,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232).withOpacity(0.40),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "-",
                                          style: GoogleFonts.inter(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xffFF0000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 42.w,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        count.toString(),
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.sp,
                                          color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: incrementCount,
                                    child: Container(
                                      width: 25.w,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232).withOpacity(0.40),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "+",
                                          style: GoogleFonts.inter(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff008000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  25.r.horizontalSpace,
                                  Icon(Icons.add_shopping_cart, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  addToCart();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.2),
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      color: const Color(0xffEB6733),
                    ),
                    child: Center(
                      child: Text(
                        "Add to Cart",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: const Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
