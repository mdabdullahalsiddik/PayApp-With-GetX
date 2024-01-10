import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/add_money_view.dart';
import 'package:pay/views/authentication/login_view.dart';
import 'package:pay/views/send_account_view.dart';

class HomeController extends GetxController {
  setLogout() async {
    await FirebaseAllFunction.auth.signOut();
    Get.offAll(loginView());
    Get.snackbar("Successful", " Logout is successful");
    update();
  }

  sendAccount() {
    Get.to(SendAccountView());
  }

  addMoney() {
    Get.to(AddMoneyView());
  }
}
