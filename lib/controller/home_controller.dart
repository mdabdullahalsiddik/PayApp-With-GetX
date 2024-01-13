import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/add_money_view.dart';
import 'package:pay/views/authentication/login_view.dart';
import 'package:pay/views/send_account_view.dart';

class HomeController extends GetxController {
  setLogout() async {
    try {
      await EasyLoading.show(status: 'loading...');
      Get.offAll(loginView());
      FirebaseAllFunction.auth.signOut();
      Get.snackbar("Successful", " Logout is successful");
      EasyLoading.dismiss();
      update();
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  sendAccount() {
    Get.to(SendAccountView());
  }

  addMoney() {
    Get.to(AddMoneyView());
  }

  dialog(context) {
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
    update();
  }

  logoutDialog(context) {
    Get.defaultDialog(
      title: "Logout",
      titleStyle: const TextStyle(color: Colors.red),
      middleText: "Are you sure?",
      onConfirm: () {
        setLogout();
      },
      onCancel: () {
        Get.back();
      },
    );
    update();
  }
}
