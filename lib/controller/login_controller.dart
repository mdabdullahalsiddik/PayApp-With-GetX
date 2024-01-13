import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/authentication/register_view.dart';
import 'package:pay/views/navigator/bottom_navigator.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var forky = GlobalKey<FormState>();
  bool passwordValidator = true;
  setTextField() async {
    if (forky.currentState!.validate()) {
      try {
        
        await FirebaseAllFunction.auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await FirebaseAllFunction.firestore
            .collection("user")
            .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
            .update({
          "token": await FirebaseAllFunction.messaging.getToken(),
        });
        Get.offAll(BottomNavigatorView());
        Get.snackbar("Successful", "Login is Successful");
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
    Get.to(RegisterView());
    update();
  }
}
