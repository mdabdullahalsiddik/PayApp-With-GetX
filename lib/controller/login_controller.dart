import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/navigator/bottom_navigator.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordValidator = true;
  setTextField() async {
    try {
      await FirebaseAllFunction.auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAll(const BottomNavigatorView());
      Get.snackbar("Successful", "Login is Successful");
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message.toString());
    }

    emailController.clear();
    passwordController.clear();
    update();
  }

  setPasswordValidator() {
    passwordValidator = !passwordValidator;

    update();
  }
}
