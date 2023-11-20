import 'dart:convert';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop/presentation/widgets/header_component.dart';

import 'category_product_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('https://fakestoreapi.com/products/categories'));

      if (response.statusCode == 200) {
        List<String> fetchedCategories =
            List<String>.from(json.decode(response.body));
        setState(() {
          categories = fetchedCategories;
        });
      } else {
      }
    // ignore: empty_catches
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    return Scaffold(
    body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: SafeArea(
          child: Column(
            children: [
              const HeaderWidget(),
              20.r.verticalSpace,
              SizedBox(
                height: 600.h,
                child: Center(
                  child: categories.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Transform.scale(
                            scale: 1.5,
                            child: const CircularProgressIndicator.adaptive(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ))
                      : ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.2, right: 12.2, bottom: 13),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => CategoryProductPage(
                                        selectedCategory: categories[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    color: themeMode == ThemeMode.dark ? const Color(0xff151518) : const Color(0xffFFFFFF),
                                  ),
                                  width: double.infinity,
                                  height: 50.h,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 15),
                                    child: Text(
                                      categories[index].toUpperCase(),
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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
