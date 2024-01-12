import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:pay/views/welcome_views.dart/splash_view.dart';

class InternetCheck extends StatefulWidget {
  const InternetCheck({super.key});

  @override
  State<InternetCheck> createState() => _InternetCheckState();
}

class _InternetCheckState extends State<InternetCheck> {
  StreamSubscription? subscription;

  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      internetCheck();
    });

    internetCheck();

    super.initState();
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  Future internetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Get.to(SplashView());
    } else {
      Get.defaultDialog(
        title: "No Internet",
        titleStyle: const TextStyle(color: Colors.red),
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
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(),
    );
  }
}
