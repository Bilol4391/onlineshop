import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:onlineshop/features/home/cart/cart_page.dart';
import 'package:onlineshop/features/home/favourite_page/favourite_page.dart';
import 'package:provider/provider.dart';

import '../../core/provider/provider.dart';

class FavouriteBadge extends StatelessWidget {
  final int itemCount;

  const FavouriteBadge({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    FavouriteProvider favouriteProvider = Provider.of<FavouriteProvider>(context);
    int itemCount = favouriteProvider.favoriteItemCount;

    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 0),
      badgeAnimation: const badges.BadgeAnimation.slide(),
      showBadge: itemCount > 0,
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Color(0xffE35027), // Replace with your desired badge color
      ),
      badgeContent: Text(favouriteProvider.favoriteItemCount.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(
        icon: Icon(Icons.favorite, size: 27, color: themeMode == ThemeMode.dark ? const Color(0xffFFFFFF) : const Color(0xff323232),),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FavouritePage()));
        },
      ),
    );
  }
}
