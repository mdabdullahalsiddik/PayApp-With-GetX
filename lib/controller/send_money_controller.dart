import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/data.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/navigator/bottom_navigator.dart';

class SendMoneyController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  int? senderAmount;
  int? receiverAmount;

  setSend() async {
    int money = int.parse(amountController.text);
    await FirebaseAllFunction.firestore
        .collection("user")
        .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
        .get()
        .then((value) {
      senderAmount = value.data()!["balance"];
    });
    await FirebaseAllFunction.firestore
        .collection("user")
        .doc(receiverMail)
        .get()
        .then((value) {
      receiverAmount = value.data()!["balance"];
    });
    if (money < senderAmount!) {
      await FirebaseAllFunction.firestore
          .collection("user")
          .doc(receiverMail)
          .update({
        "balance": senderAmount! + money,
      });
      await FirebaseAllFunction.firestore
          .collection("user")
          .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
          .update({
        "balance": senderAmount! - money,
      });
      Get.snackbar("Successful", "Send Money is Successful");
      amountController.clear();
      Get.offAll(const BottomNavigatorView());
      update();
    } else {
      Get.snackbar("Error", "You don't have enough money");
    }
  }
}
