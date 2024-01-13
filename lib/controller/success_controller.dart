import 'package:get/get.dart';
import 'package:pay/views/navigator/bottom_navigator.dart';

class SuccessController extends GetxController {
  back() {
    Get.offAll(BottomNavigatorView());
    update();
  }
}
