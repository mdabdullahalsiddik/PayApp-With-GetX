import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/internet_controller.dart';
import 'package:pay/controller/splash_controller.dart';
import 'package:pay/static/all%20colors/all_colors.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});
  final InternetController internetController = Get.put(InternetController());
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.primaryColor,
      body: Center(
        child: Image.asset("assets/images/icon.png"),
      ),
    );
  }
}
