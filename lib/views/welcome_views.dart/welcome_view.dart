// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pay/controller/internet_controller.dart';
import 'package:pay/static/all%20texts/all_texts.dart';
import 'package:pay/views/authentication/login_view.dart';
import 'package:pay/widgets/custom_button.dart';

class WelcomeView extends StatelessWidget {
   WelcomeView({super.key});
  final InternetController internetController = Get.put(InternetController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
          title: "Exit",
          titleStyle: const TextStyle(color: Colors.red),
          middleText: "Are you sure?",
          onConfirm: () {
            exit(0);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );

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
                  onTap: () {
                    Get.offAll(loginView());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
