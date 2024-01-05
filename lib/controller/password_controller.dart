
import 'package:get/get.dart';

class PasswordController extends GetxController {
  bool passwordValidator = true;

  setPasswordValidator() {
    passwordValidator = !passwordValidator;

    update();
  }
}
