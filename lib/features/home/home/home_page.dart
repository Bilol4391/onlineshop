import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlineshop/core/models/category_product_model.dart';
import 'package:onlineshop/core/models/category_model.dart';
import 'package:onlineshop/core/models/product_model.dart';
import 'package:onlineshop/core/services/api_service.dart';
import 'package:onlineshop/features/home/widgets/empty_products.dart';
import 'package:onlineshop/presentation/widgets/header_component.dart';
import 'package:onlineshop/presentation/widgets/loading_component.dart';
import 'package:onlineshop/features/home/widgets/product_card.dart';
import 'package:onlineshop/features/home/widgets/swiper_image_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  late Future<ProductCategory> productCategory;

  @override
  void initState() {
    super.initState();
    productCategory = apiService.getProductsAndCategories();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              // ignore: prefer_const_constructors
              HeaderWidget(),
              FutureBuilder<ProductCategory>(
                future: productCategory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    ProductCategory productCategoryData = snapshot.data!;
                    List<Product> productList = productCategoryData.products;
                    List<Category> categoryList =
                        productCategoryData.categories;

                    List<String> imageList = [
                      "assets/images/discount_3.png",
                      "assets/images/discount_1.png",
                      "assets/images/discount_2.png",
                    ];

                    return Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.sp, vertical: 0.sp),
                            child: Column(
                              children: [
                                10.r.verticalSpace,
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        HomeSwiper(
                                          imageList: imageList,
                                        ),
                                        DefaultTabController(
                                          length: categoryList.length,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: ButtonsTabBar(
                                                  backgroundColor:
                                                      const Color(0xffEB6733),
                                                  unselectedBackgroundColor:
                                                      themeMode ==
                                                              ThemeMode.dark
                                                          ? const Color(
                                                              0xff0F1828)
                                                          : Colors.white,
                                                  labelStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  unselectedLabelStyle:
                                                      TextStyle(
                                                          color: themeMode ==
                                                                  ThemeMode.dark
                                                              ? const Color(
                                                                  0xffFFFFFF)
                                                              : const Color(
                                                                  0xff000000),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13.sp),
                                                  borderWidth: 1,
                                                  unselectedBorderColor:
                                                      const Color(0xffEB6733),
                                                  borderColor:
                                                      const Color(0xffEB6733),
                                                  radius: 10,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                  tabs: categoryList
                                                      .map((category) => Tab(
                                                          text: category.name
                                                              .toUpperCase()))
                                                      .toList(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: calculateTotalHeight(
                                                    productList),
                                                child: TabBarView(
                                                  children: categoryList
                                                      .map((category) {
                                                    List<Product>
                                                        filteredProducts =
                                                        productList
                                                            .where((product) =>
                                                                product
                                                                    .category ==
                                                                category.name)
                                                            .toList();
                                                    return filteredProducts
                                                            .isEmpty
                                                        ? const EmptyProducts()
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10,
                                                                    top: 20),
                                                            child: GridView
                                                                .builder(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              gridDelegate:
                                                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                                                maxCrossAxisExtent:
                                                                    240,
                                                                childAspectRatio:
                                                                    0.85 / 1.4,
                                                                crossAxisSpacing:
                                                                    13,
                                                                mainAxisSpacing:
                                                                    10,
                                                              ),
                                                              itemCount:
                                                                  filteredProducts
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                Product
                                                                    product =
                                                                    filteredProducts[
                                                                        index];
                                                                return ProductCard(
                                                                  product:
                                                                      product,
                                                                );
                                                              },
                                                            ),
                                                          );
                                                  }).toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
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
      ),
    );
  }
}

// Function to calculate the total height of the products
double calculateTotalHeight(List<Product> products) {
  double totalHeight = 0.0;

  for (Product product in products) {
    // Calculate the height of each product item and add it to the total height
    totalHeight += calculateProductHeight(product);
  }

  // Add extra spacing or padding as needed
  totalHeight += 1;

  return totalHeight;
}

// Function to calculate the height of each product item
double calculateProductHeight(Product product) {
  // Adjust this calculation based on the actual height occupied by each product item
  return 40 + 5 + 5 + 3 + 1;
}
