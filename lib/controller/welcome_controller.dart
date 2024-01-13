import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/views/authentication/login_view.dart';

class WelcomeController extends GetxController {
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

  route() {
    Get.offAll(loginView());
    update();
  }
}
