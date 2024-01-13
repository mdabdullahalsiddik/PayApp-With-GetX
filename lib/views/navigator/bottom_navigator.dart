import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/internet_controller.dart';
import 'package:pay/controller/navigator_controller.dart';

class BottomNavigatorView extends StatelessWidget {
  BottomNavigatorView({super.key});

  final NavigatorController navigatorController =
      Get.put(NavigatorController());

  final InternetController internetController = Get.put(InternetController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigatorController>(
      builder: (controller) {
        return Scaffold(
          body: navigatorController.pages[navigatorController.selectIndex],
          bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 0,
              unselectedFontSize: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: navigatorController.selectIndex,
              onTap: (value) {
                navigatorController.setSelectIndex(value);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_outlined,
                  ),
                  label: "",
                ),
              ]),
        );
      },
    );
  }
}
