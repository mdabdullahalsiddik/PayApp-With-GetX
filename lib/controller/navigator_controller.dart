import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/views/account_view.dart';
import 'package:pay/views/home_view.dart';

class NavigatorController extends GetxController {
  int selectIndex = 0;

  List pages = [
    HomeView(),
    AccountView(),
  ];
  setSelectIndex(index) {
    selectIndex = index;
    update();
  }
}
