import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop/features/home/profile/profile_page.dart';

import 'cart/cart_page.dart';
import 'category/category_page.dart';
import 'home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

int _currentPage = 0;
final List _children = [
  const HomePage(),
  const CategoryPage(),
  const CartPage(),
  const ProfilePage(),
];




class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xffFFFFFF),
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 20.0),
      //     child: Container(
      //         width: 200.w,
      //         height: 50.h,
      //         child: Image.asset(
      //           "assets/icons/storelingLogo.png",
      //         )),
      //   ),
      //   elevation: 0.1,
      // ),
      body: _children[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentPage,
        selectedItemColor: const Color(0xffEB6733), // Color for selected item
        unselectedItemColor: const Color(0xff323232),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff222222),),
            label: "Profile",
          ),
        ],
      ),
    );
  }
  void onTabTapped(int index){
    setState(() {
      _currentPage = index;
    });
  }
}
