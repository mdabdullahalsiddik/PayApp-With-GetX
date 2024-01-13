import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/data.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/send_money_view.dart';

class SendAccountController extends GetxController {
  final TextEditingController mailController = TextEditingController();
  var forky = GlobalKey<FormState>();
  String? mail;
  setBack() {
    Get.back();
    update();
  }

  setData() async {
    if (forky.currentState!.validate()) {
      try {
        await FirebaseAllFunction.firestore
            .collection("user")
            .doc(mailController.text)
            .get()
            .then((value) {
          mail = value.data()!["mail"].toString();
        });

        if (mailController.text != FirebaseAllFunction.user) {
          if (mailController.text == mail) {
            receiverMail = mail;
            senderMail = FirebaseAllFunction.user;
            Get.to(SendMoneyView());
            mailController.clear();
          }
        } else {
          Get.snackbar("Error", "You can't send account to your own account");
        }
      } catch (e) {
        Get.snackbar("Error", "$e");
      }
    }
    update();
  }
}
