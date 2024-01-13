// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/authentication/login_view.dart';
import 'package:pay/views/profile_view.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var forky = GlobalKey<FormState>();
  bool passwordValidator = true;
  setTextField() async {
    if (forky.currentState!.validate()) {
      try {
        await EasyLoading.show(status: 'loading...');

        await FirebaseAllFunction.auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Get.offAll(ProfileView());
        Get.snackbar("Successful", "Register is Successful");
        EasyLoading.dismiss();
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", e.message.toString());
      }

      emailController.clear();
      passwordController.clear();
      update();
    }
  }

  setPasswordValidator() {
    passwordValidator = !passwordValidator;

    update();
  }

  route() {
    Get.to(loginView());
    update();
  }
}
