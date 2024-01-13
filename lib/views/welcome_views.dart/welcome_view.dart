// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/internet_controller.dart';
import 'package:pay/controller/welcome_controller.dart';
import 'package:pay/static/all%20texts/all_texts.dart';
import 'package:pay/widgets/custom_button.dart';

class WelcomeView extends GetView<WelcomeController> {
  WelcomeView({super.key});
  final InternetController internetController = Get.put(InternetController());
  final WelcomeController welcomeController = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            welcomeController.dialog(context);

            return false;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.asset("assets/images/icon.png"),
                        AllTexts.welcomeText,
                      ],
                    ),
                    CustomButton(
                      text: 'Start',
                      onTap:() => welcomeController.route(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
