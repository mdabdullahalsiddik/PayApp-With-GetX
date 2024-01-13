import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/services%20/notification_api.dart';
import 'package:pay/views/navigator/bottom_navigator.dart';

class AddMoneyController extends GetxController {
  final TextEditingController addMoneyController = TextEditingController();
  var forky = GlobalKey<FormState>();
  int? money;
  int? senderAmount;
  // ignore: prefer_typing_uninitialized_variables
  var senderToken;
  // ignore: prefer_typing_uninitialized_variables
  var senderImage;
  String? senderName;
  addMoney() async {
    if (forky.currentState!.validate()) {
     try {
        money = int.parse(addMoneyController.text);
     await EasyLoading.show(status: 'loading...');
      await FirebaseAllFunction.userCollection.get().then((value) {
        senderAmount = value.data()!["balance"];
        senderToken = value.data()!["token"];
        senderImage = value.data()!["image"];
        senderName = value.data()!["name"];
      });
      await FirebaseAllFunction.userCollection.update({
        "balance": money! + senderAmount!,
      });
      await NotificationApi().triggerNotification(
          fcmToken: senderToken,
          title: "Add Money",
          body: "You just add  $money taka");
      await FirebaseAllFunction.firestore.collection("history").add({
        "receiver": FirebaseAllFunction.auth.currentUser!.email.toString(),
        "amount": money,
        "date": DateTime.now().toString(),
        "receiver_image": "",
        "receiver_name": "",
        "sender": "Add Money",
        "sender_image": senderImage,
        "sender_name": senderName,
      });
      Get.snackbar("Successful", "Add Money is Successful");
      addMoneyController.clear();
      Get.offAll(BottomNavigatorView());
      EasyLoading.dismiss();
     } catch (e) {
       Get.snackbar("Error", "$e");
     }
    }
    update();
  }

  appBarRoute() {
    Get.back();
    update();
  }
}
