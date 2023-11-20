import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:onlineshop/features/home/cart/cart_page.dart';
import 'package:provider/provider.dart';

import '../../core/provider/provider.dart';

class ShoppingCartBadge extends StatelessWidget {
  final int itemCount;

  const ShoppingCartBadge({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    int itemCount = cartProvider.cartItemCount;

    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 0),
      badgeAnimation: const badges.BadgeAnimation.slide(),
      showBadge: cartProvider.cartItemCount > 0,
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Color(0xffE35027), // Replace with your desired badge color
      ),
      badgeContent: Text(cartProvider.cartItemCount.toString(), style: TextStyle(color: Colors.white),),
      child: IconButton(
        icon: Icon(Icons.shopping_cart, size: 27, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232),),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartPage()));
        },
      ),
    );
  }
}
