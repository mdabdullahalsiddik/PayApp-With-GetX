import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/home_controller.dart';
import 'package:pay/function/firebase_function.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text("Sid"),
                  accountEmail: Text(
                    FirebaseAllFunction.auth.currentUser!.email.toString(),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      title: "Logout",
                      titleStyle: const TextStyle(color: Colors.red),
                      middleText: "Are you sure?",
                      onConfirm: () {
                        homeController.setLogout();
                      },
                      onCancel: () {
                        Get.back();
                      },
                    );
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.logout,
                    ),
                    title: Text("logout"),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(),
        );
      },
    );
  }
}
