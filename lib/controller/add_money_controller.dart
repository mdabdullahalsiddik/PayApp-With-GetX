import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/navigator/bottom_navigator.dart';

class AddMoneyController extends GetxController {
  final TextEditingController addMoneyController = TextEditingController();
  var forky = GlobalKey<FormState>();
  int? money;
  int? senderAmount;
  addMoney() async {
    if (forky.currentState!.validate()) {
      money = int.parse(addMoneyController.text);
      await FirebaseAllFunction.firestore
          .collection("user")
          .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
          .get()
          .then((value) {
        senderAmount = value.data()!["balance"];
      });
      await FirebaseAllFunction.firestore
          .collection("user")
          .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
          .update({
        "balance": money! + senderAmount!,
      });
      Get.snackbar("Successful", "Add Money is Successful");
      addMoneyController.clear();
      Get.offAll(const BottomNavigatorView());
    }
    update();
  }
}
