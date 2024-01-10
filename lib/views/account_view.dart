import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/account_controller.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/widgets/custom_listtile.dart';

class AccountView extends StatelessWidget {
  AccountView({super.key});
  final AccountController accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: StreamBuilder(
          stream: FirebaseAllFunction.firestore
              .collection("user")
              .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
              .snapshots(),
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
    );
  }
}