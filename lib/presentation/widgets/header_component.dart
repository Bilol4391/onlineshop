
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlineshop/presentation/widgets/badge_favourite.dart';
import 'package:provider/provider.dart';

import '../../core/provider/provider.dart';
import 'badge_component.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            width: 140.w,
            height: 27,
            child: Image.asset("assets/icons/storelingLogo.png"),
          ),
          const Spacer(),
          FavouriteBadge(itemCount: favouriteProvider.favoriteItemCount),
          SizedBox(width: 7.sp),
          ShoppingCartBadge(itemCount: cartProvider.cartItemCount,),
        ],
      ),
    );
  }
}

