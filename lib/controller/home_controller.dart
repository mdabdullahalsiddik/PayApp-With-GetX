import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/authentication/login_view.dart';

class HomeController extends GetxController {
  setLogout() {
    FirebaseAllFunction.auth.signOut();
    Get.offAll(loginView());
    Get.snackbar("Successful", " Logout is successful");
  }
}