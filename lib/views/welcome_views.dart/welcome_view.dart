import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pay/static/all%20texts/all_texts.dart';
import 'package:pay/views/authentication/login_view.dart';
import 'package:pay/widgets/custom_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
