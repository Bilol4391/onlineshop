import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlineshop/core/auth/splash_page.dart';
import 'package:onlineshop/core/provider/provider.dart';
import 'package:onlineshop/features/home/main_screen.dart';
import 'package:onlineshop/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavouriteProvider()),
      ],
      child: EasyDynamicThemeWidget(
        child: const MyApp(),
        ),
      ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeMode = EasyDynamicTheme.of(context).themeMode;
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              title: 'Localization',
              debugShowCheckedModeBanner: false,
              theme: lightThemeData,
              darkTheme: darkThemeData,
              themeMode: EasyDynamicTheme.of(context).themeMode,
              // home: const ProductListScreen());
              home: const SplashPage());
        });
  }
}
