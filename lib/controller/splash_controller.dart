import 'package:get/get.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/navigator/bottom_navigator.dart';
import 'package:pay/views/welcome_views.dart/welcome_view.dart';

class SplashController extends GetxController {
  time() async {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      FirebaseAllFunction.auth.currentUser == null
          ? Get.offAll( WelcomeView())
          : Get.offAll(
              const BottomNavigatorView(),
            );
    });
    update();
  }

  @override
  void onInit() {
    time();
    super.onInit();
  }
}
