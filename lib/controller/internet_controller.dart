import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  late final StreamSubscription? subscription;
  Future internetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Get.back();
    } else {
      Get.defaultDialog(
        title: "No Internet",
        titleStyle: const TextStyle(
          color: Colors.red,
        ),
        middleText: "Please check your internet connection",
        onConfirm: () {
          exit(0);
        },
        onCancel: () {
          internetCheck();
        },
      );
    }
  }

  @override
  void onInit() {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      internetCheck();
    });

    internetCheck();
    super.onInit();
  }

  @override
  void onClose() {
    subscription!.cancel();
    super.onClose();
  }
}
