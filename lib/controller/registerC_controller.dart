import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  setTextField() async {
    try {
     
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.snackbar("Successful", "Register is Successful");
    } on FirebaseAuthException catch (e) {
     
      Get.snackbar("Error", e.message.toString());
      
    }

    emailController.clear();
    passwordController.clear();
    update();
  }
}
