// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/data.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/services%20/notification_api.dart';
import 'package:pay/views/success_view.dart';

class SendMoneyController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  var forky = GlobalKey<FormState>();
  int? senderAmount;
  int? receiverAmount;
  String? senderName;
  String? receiverName;
  var senderToken;
  var receiverToken;
  var senderImage;
  var receiverImage;

  setSend() async {
    if (forky.currentState!.validate()) {
      int money = int.parse(amountController.text);
      await FirebaseAllFunction.firestore
          .collection("user")
          .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
          .get()
          .then((value) {
        senderAmount = value.data()!["balance"];
        senderName = value.data()!["name"];
        senderToken = value.data()!["token"];
        senderImage = value.data()!["image"];
      });
      await FirebaseAllFunction.firestore
          .collection("user")
          .doc(receiverMail)
          .get()
          .then((value) {
        receiverAmount = value.data()!["balance"];
        receiverName = value.data()!["name"];
        receiverToken = value.data()!["token"];
        receiverImage = value.data()!["image"];
      });
      if (money <= senderAmount!) {
        await FirebaseAllFunction.firestore
            .collection("user")
            .doc(receiverMail)
            .update({
          "balance": receiverAmount! + money,
        });
        await FirebaseAllFunction.firestore
            .collection("user")
            .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
            .update({
          "balance": senderAmount! - money,
        });
        sendMoney = money;
        await NotificationApi().triggerNotification(
            fcmToken: senderToken,
            title: "Send Money",
            body: "You just send $money taka from $receiverMail");
        await NotificationApi().triggerNotification(
            fcmToken: receiverToken,
            title: "Received Money",
            body: "You just received $money taka from $senderMail");
        await FirebaseAllFunction.firestore.collection("history").add({
          "sender": FirebaseAllFunction.auth.currentUser!.email.toString(),
          "receiver": receiverMail.toString(),
          "amount": money,
          "date": DateTime.now().toString(),
          "sender_image": senderImage,
          "receiver_image": receiverImage,
           "sender_name": senderName,
          "receiver_name": receiverName,

        });

        Get.snackbar("Successful", "Send Money is Successful");
        amountController.clear();
        Get.offAll(const SuccessView());
        update();
      } else {
        Get.snackbar("Error", "You don't have enough money");
      }
    }
  }
}
