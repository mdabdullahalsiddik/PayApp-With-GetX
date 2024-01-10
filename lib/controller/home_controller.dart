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
    await EasyLoading.show(status: 'loading...');
    Get.offAll(loginView());
    FirebaseAllFunction.auth.signOut();
    Get.snackbar("Successful", " Logout is successful");
    EasyLoading.dismiss();
    update();
  }

  sendAccount() {
    Get.to(SendAccountView());
  }

  addMoney() {
    Get.to(AddMoneyView());
  }
}
