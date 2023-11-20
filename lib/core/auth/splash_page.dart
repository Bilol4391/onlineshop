import 'package:flutter/material.dart';
import 'package:onlineshop/core/auth/chooseLanguage/chooselanguage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Delay the navigation to PhoneNumber page by 5 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const Chooselanguage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
        child: Image.asset("assets/icons/storelingLogo.png"),
    ));
  }
}
