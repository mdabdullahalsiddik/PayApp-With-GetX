import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/services%20/theme_service.dart';

class AccountController extends GetxController {
  setTheme() {
    
    ThemeService().changeThemeMode();
    update();
  }
}
