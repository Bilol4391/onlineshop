// import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:onlineshop/presentation/widgets/header_component.dart';
//
// class CartPage1 extends StatefulWidget {
//   const CartPage1({super.key});
//
//   @override
//   State<CartPage1> createState() => _CartPage1State();
// }
//
// class _CartPage1State extends State<CartPage1> {
//   bool showImage = true;
//
//   void toggleImageVisibility() {
//     setState(() {
//       showImage = !showImage;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Display the image for 5 seconds, then change to another container.
//     Future.delayed(const Duration(seconds: 5), () {
//       setState(() {
//         showImage = false;
//       });
//     });
//   }
//
//   int count = 1; // Initial count value
//
//   void incrementCount() {
//     setState(() {
//       count++;
//     });
//   }
//
//   void decrementCount() {
//     setState(() {
//       if (count > 0) {
//         count--;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeMode = EasyDynamicTheme.of(context).themeMode;
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Column(
//           children: [
//             const HeaderWidget(),
//             20.r.verticalSpace,
//             showImage
//                 ? Center(child: Image.asset("assets/images/emptyCart.png"))
//                 : Column(
//               children: [
//                 15.r.verticalSpace,
//
//
//
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Container(
//                     width: double.infinity,
//                     height: 140.h,
//                     decoration: BoxDecoration(
//                       borderRadius:
//                       BorderRadius.all(Radius.circular(10.r)),
//                       border: Border.all(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey),
//                     ),
//                     child: Row(
//                       children: [
//                         17.r.horizontalSpace,
//                         SizedBox(
//                           width: 60.w,
//                           height: 116.h,
//                           child: Image.network(product.image)
//                         ),
//                         20.r.horizontalSpace,
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             20.r.verticalSpace,
//                             Text(
//                               product.title,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 16,
//                                 color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
//                               ),
//                             ),
//                             5.verticalSpace,
//                             Row(
//                               children: [
//                                 Text(
//                                   "KRW",
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
//                                   ),
//                                 ),
//                                 SizedBox(width: 5),
//                                 Text(
//                                   product.price,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 14,
//                                     color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             8.verticalSpace,
//                             Row(
//                               children: [
//                                 Text(
//                                   product.price,
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w600,
//                                     color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey.withOpacity(0.4),
//                                     decoration:
//                                     TextDecoration.lineThrough,
//                                     fontStyle: FontStyle.italic,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Text(
//                                   "-20%",
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w400,
//                                     color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             10.r.verticalSpace,
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: decrementCount,
//                                   child: Container(
//                                     width: 25.w,
//                                     height: 25,
//                                     decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         border: Border.all(
//                                             color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232)
//                                                 .withOpacity(0.40))),
//                                     child: Center(
//                                         child: Text(
//                                           "-", textAlign: TextAlign.center,
//                                           style: GoogleFonts.inter(
//                                               fontSize: 20.sp,
//                                               fontWeight: FontWeight.w700,
//                                               color: const Color(0xffFF0000)),
//                                         )),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 42.w,
//                                   height: 30,
//                                   child: Center(
//                                     child: Text(
//                                       count.toString(),
//                                       style: GoogleFonts.inter(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 18.sp,
//                                           color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222)),
//                                     ),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: incrementCount,
//                                   child: Container(
//                                     width: 25.w,
//                                     height: 25,
//                                     decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         border: Border.all(
//                                             color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232)
//                                                 .withOpacity(0.40))),
//                                     child: Center(
//                                         child: Text(
//                                           "+",
//                                           style: GoogleFonts.inter(
//                                               fontSize: 20.sp,
//                                               fontWeight: FontWeight.w700,
//                                               color: const Color(0xff008000)),
//                                         )),
//                                   ),
//                                 ),
//                                 80.r.horizontalSpace,
//                                 Icon(
//                                   Icons.remove_shopping_cart,
//                                   color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Color(0xff323232),
//                                 ),
//                               ],
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//
//
//
//
//
//
//
//
//                 240.r.verticalSpace,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 22.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Image.asset(
//                                   'assets/images/succesfull.png', // Replace with your image path
//                                   width: 270.w,
//                                 ),
//                               ],
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   toggleImageVisibility();
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Text(
//                                   'Close',
//                                   style: TextStyle(
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.blue,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       height: 50.h,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(15.r)),
//                           color: const Color(0xffEB6733)
//                       ),
//                       child: Center(child: Text("Checkout", style: GoogleFonts.inter(fontSize: 17.sp, fontWeight: FontWeight.w600, color: const Color(0xffFFFFFF)),),),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class CartPage extends StatefulWidget {
//   const CartPage({super.key, required product, required int quantity});
//
//   @override
//   _CartPageState createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//   List<int> cartItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadCartItems();
//   }
//
//   void loadCartItems() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? cartItemStrings = prefs.getStringList('cart_items');
//     if (cartItemStrings != null) {
//       setState(() {
//         cartItems = cartItemStrings.map((e) => int.parse(e)).toList();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Cart Items:',import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
//         import 'package:flutter/material.dart';
//         import 'package:flutter_screenutil/flutter_screenutil.dart';
//         import 'package:google_fonts/google_fonts.dart';
//         import 'package:onlineshop/presentation/widgets/header_component.dart';
//
//         class CartPage1 extends StatefulWidget {
//         const CartPage1({super.key});
//
//         @override
//         State<CartPage1> createState() => _CartPage1State();
//         }
//
//         class _CartPage1State extends State<CartPage1> {
//         bool showImage = true;
//
//         void toggleImageVisibility() {
//         setState(() {
//         showImage = !showImage;
//         });
//         }
//
//         @override
//         void initState() {
//         super.initState();
//         // Display the image for 5 seconds, then change to another container.
//         Future.delayed(const Duration(seconds: 5), () {
//         setState(() {
//         showImage = false;
//         });
//         });
//         }
//
//         int count = 1; // Initial count value
//
//         void incrementCount() {
//         setState(() {
//         count++;
//         });
//         }
//
//         void decrementCount() {
//         setState(() {
//         if (count > 0) {
//         count--;
//         }
//         });
//         }
//
//         @override
//         Widget build(BuildContext context) {
//         final themeMode = EasyDynamicTheme.of(context).themeMode;
//         return SafeArea(
//         child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Column(
//         children: [
//         const HeaderWidget(),
//         20.r.verticalSpace,
//         showImage
//         ? Center(child: Image.asset("assets/images/emptyCart.png"))
//             : Column(
//         children: [
//         15.r.verticalSpace,
//         Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25),
//         child: Container(
//         width: double.infinity,
//         height: 140.h,
//         decoration: BoxDecoration(
//         borderRadius:
//         BorderRadius.all(Radius.circular(10.r)),
//         border: Border.all(color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey),
//         ),
//         child: Row(
//         children: [
//         17.r.horizontalSpace,
//         SizedBox(
//         width: 60.w,
//         height: 116.h,
//         child: Image.asset(
//         "assets/images/oil.png",
//         fit: BoxFit.contain,
//         ),
//         ),
//         20.r.horizontalSpace,
//         Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         20.r.verticalSpace,
//         Text(
//         "Sunflower oil",
//         style: TextStyle(
//         fontWeight: FontWeight.w400,
//         fontSize: 16,
//         color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
//         ),
//         ),
//         5.verticalSpace,
//         Row(
//         children: [
//         Text(
//         "KRW",
//         style: TextStyle(
//         fontSize: 12,
//         fontWeight: FontWeight.w400,
//         color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
//         ),
//         ),
//         SizedBox(width: 5),
//         Text(
//         "18,000",
//         style: TextStyle(
//         fontWeight: FontWeight.w700,
//         fontSize: 14,
//         color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
//         ),
//         )
//         ],
//         ),
//         8.verticalSpace,
//         Row(
//         children: [
//         Text(
//         "KRW 20,000",
//         style: TextStyle(
//         fontSize: 10,
//         fontWeight: FontWeight.w600,
//         color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.grey.withOpacity(0.4),
//         decoration:
//         TextDecoration.lineThrough,
//         fontStyle: FontStyle.italic,
//         ),
//         ),
//         const SizedBox(width: 5),
//         Text(
//         "-20%",
//         style: TextStyle(
//         fontSize: 10,
//         fontWeight: FontWeight.w400,
//         color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Colors.black,
//         ),
//         ),
//         ],
//         ),
//         10.r.verticalSpace,
//         Row(
//         children: [
//         GestureDetector(
//         onTap: decrementCount,
//         child: Container(
//         width: 25.w,
//         height: 25,
//         decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//         color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232)
//             .withOpacity(0.40))),
//         child: Center(
//         child: Text(
//         "-", textAlign: TextAlign.center,
//         style: GoogleFonts.inter(
//         fontSize: 20.sp,
//         fontWeight: FontWeight.w700,
//         color: const Color(0xffFF0000)),
//         )),
//         ),
//         ),
//         SizedBox(
//         width: 42.w,
//         height: 30,
//         child: Center(
//         child: Text(
//         count.toString(),
//         style: GoogleFonts.inter(
//         fontWeight: FontWeight.w700,
//         fontSize: 18.sp,
//         color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222)),
//         ),
//         ),
//         ),
//         GestureDetector(
//         onTap: incrementCount,
//         child: Container(
//         width: 25.w,
//         height: 25,
//         decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//         color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232)
//             .withOpacity(0.40))),
//         child: Center(
//         child: Text(
//         "+",
//         style: GoogleFonts.inter(
//         fontSize: 20.sp,
//         fontWeight: FontWeight.w700,
//         color: const Color(0xff008000)),
//         )),
//         ),
//         ),
//         80.r.horizontalSpace,
//         Icon(
//         Icons.remove_shopping_cart,
//         color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : Color(0xff323232),
//         ),
//         ],
//         )
//         ],
//         )
//         ],
//         ),
//         ),
//         ),
//         240.r.verticalSpace,
//         Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 22.0),
//         child: GestureDetector(
//         onTap: () {
//         showDialog(
//         context: context,
//         builder: (BuildContext context) {
//         return AlertDialog(
//         content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//         Image.asset(
//         'assets/images/succesfull.png', // Replace with your image path
//         width: 270.w,
//         ),
//         ],
//         ),
//         actions: [
//         TextButton(
//         onPressed: () {
//         toggleImageVisibility();
//         Navigator.of(context).pop();
//         },
//         child: Text(
//         'Close',
//         style: TextStyle(
//         fontSize: 16.sp,
//         fontWeight: FontWeight.w600,
//         color: Colors.blue,
//         ),
//         ),
//         )
//         ],
//         );
//         },
//         );
//         },
//         child: Container(
//         width: double.infinity,
//         height: 50.h,
//         decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(15.r)),
//         color: const Color(0xffEB6733)
//         ),
//         child: Center(child: Text("Checkout", style: GoogleFonts.inter(fontSize: 17.sp, fontWeight: FontWeight.w600, color: const Color(0xffFFFFFF)),),),
//         ),
//         ),
//         )
//         ],
//         )
//         ],
//         ),
//         ),
//         );
//         }
//         }
//
//
//
//         class CartPage extends StatefulWidget {
//         const CartPage({super.key, required product, required int quantity});
//
//         @override
//         _CartPageState createState() => _CartPageState();
//         }
//
//         class _CartPageState extends State<CartPage> {
//         List<int> cartItems = [];
//
//         @override
//         void initState() {
//         super.initState();
//         loadCartItems();
//         }
//
//         void loadCartItems() async {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         List<String>? cartItemStrings = prefs.getStringList('cart_items');
//         if (cartItemStrings != null) {
//         setState(() {
//         cartItems = cartItemStrings.map((e) => int.parse(e)).toList();
//         });
//         }
//         }
//
//         @override
//         Widget build(BuildContext context) {
//         return Scaffold(
//         appBar: AppBar(
//         title: Text('Cart'),
//         ),
//         body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         Text(
//         'Cart Items:',
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 16),
//         Expanded(
//         child: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//         return ListTile(
//         title: Text('Product ID: ${cartItems[index]}'),
//         // Add more details or customize as needed
//         );
//         },
//         ),
//         ),
//         ],
//         ),
//         ),
//         );
//         }
//         }
//
//
//
//
//
//             import 'dart:convert';
//
//             import 'package:flutter/material.dart';
//             import 'package:shared_preferences/shared_preferences.dart';
//
//             import '../../../core/models/product_model.dart';
//
//             class CartPage extends StatefulWidget {
//         const CartPage({super.key});
//
//         @override
//         _CartPageState createState() => _CartPageState();
//         }
//
//             class _CartPageState extends State<CartPage> {
//         List<Product> cartProducts = [];
//
//         @override
//         void initState() {
//         super.initState();
//         loadCartProducts();
//         }
//
//         Future<void> loadCartProducts() async {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         List<String> cartItems = prefs.getStringList('cart_items') ?? [];
//
//         for (String productId in cartItems) {
//         String? productJson = prefs.getString('product_$productId');
//         if (productJson != null) {
//         Product product = Product.fromJson(jsonDecode(productJson));
//         cartProducts.add(product);
//         }
//         }
//
//         setState(() {});
//         }
//
//         @override
//         Widget build(BuildContext context) {
//         return Scaffold(
//         appBar: AppBar(
//         title: Text('Cart'),
//         ),
//         body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         Text(
//         'Cart Items:',
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 16),
//         Expanded(
//         child: ListView.builder(
//         itemCount: cartProducts.length,
//         itemBuilder: (context, index) {
//         Product product = cartProducts[index];
//         return ListTile(
//         // title: Text('Product ID: ${cartItems[index]}'),
//         title: Text(product.title),
//         leading: Image.network(product.image),
//         subtitle: Text("${product.price}"),
//         // Add more details or customize as needed
//         );
//         },
//         ),
//         ),
//         ],
//         ),
//         ),
//         );
//         }
//         }
//
//
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('Product ID: ${cartItems[index]}'),
//                     // Add more details or customize as needed
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../core/models/product_model.dart';
//
// class CartPage extends StatefulWidget {
//   const CartPage({super.key});
//
//   @override
//   _CartPageState createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//   List<Product> cartProducts = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadCartProducts();
//   }
//
//   Future<void> loadCartProducts() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> cartItems = prefs.getStringList('cart_items') ?? [];
//
//     for (String productId in cartItems) {
//       String? productJson = prefs.getString('product_$productId');
//       if (productJson != null) {
//         Product product = Product.fromJson(jsonDecode(productJson));
//         cartProducts.add(product);
//       }
//     }
//
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Cart Items:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: cartProducts.length,
//                 itemBuilder: (context, index) {
//                   Product product = cartProducts[index];
//                   return ListTile(
//                     // title: Text('Product ID: ${cartItems[index]}'),
//                     title: Text(product.title),
//                     leading: Image.network(product.image),
//                     subtitle: Text("${product.price}"),
//                     // Add more details or customize as needed
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
