// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/account_controller.dart';
import 'package:pay/controller/internet_controller.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/widgets/custom_list_tile.dart';

class AccountView extends StatelessWidget {
  AccountView({super.key});
  final AccountController accountController = Get.put(AccountController());
  final InternetController internetController = Get.put(InternetController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: StreamBuilder(
            stream: FirebaseAllFunction.userCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.data()!;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(data["image"].toString()),
                      ),
                      Column(
                        children: [
                          CustomListTile(
                            icon: Icons.person,
                            text: data["name"],
                          ),
                          CustomListTile(
                            icon: Icons.mail,
                            text: data["mail"],
                          ),
                          CustomListTile(
                            icon: Icons.phone,
                            text: data["phone"],
                          ),
                          CustomListTile(
                            icon: Icons.credit_card_sharp,
                            text: data["nid"],
                          ),
                          CustomListTile(
                            icon: Icons.date_range,
                            text: data["birthday"],
                          ),
                          GetBuilder<AccountController>(
                            builder: (controller) {
                              return InkWell(
                                onTap: () {
                                  accountController.setTheme();
                                },
                                child: CustomListTile(
                                  icon: Icons.dark_mode_outlined,
                                  text: "Dark",
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.hasError);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
