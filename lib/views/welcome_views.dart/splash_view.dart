import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pay/static/all%20colors/all_colors.dart';
import 'package:pay/views/welcome_views.dart/welcome_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5))
        .then((value) => Get.to(const WelcomeView()));

    return Scaffold(
      backgroundColor: AllColors.primaryColor,
      body: Center(
        child: Image.asset("assets/images/icon.png"),
      ),
    );
  }
}
