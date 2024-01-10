import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/home_controller.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/static/all%20colors/all_colors.dart';
import 'package:pay/widgets/custom_manu_bottom.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
            drawer: StreamBuilder(
              stream: FirebaseAllFunction.firestore
                  .collection("user")
                  .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.data()!;
                  return Drawer(
                    child: ListView(
                      children: [
                        UserAccountsDrawerHeader(
                          decoration: const BoxDecoration(
                            color: AllColors.primaryColor,
                          ),
                          currentAccountPicture: CircleAvatar(
                            backgroundImage: NetworkImage(
                              data["image"].toString(),
                            ),
                          ),
                          accountName: Text(data["name"].toString()),
                          accountEmail: Text(
                            FirebaseAllFunction.auth.currentUser!.email
                                .toString(),
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
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.hasError);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            appBar: AppBar(
              backgroundColor: AllColors.primaryColor,
              elevation: 0,
            ),
            body: StreamBuilder(
              stream: FirebaseAllFunction.firestore
                  .collection("user")
                  .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.data()!;
                  return Column(
                    children: [
                      Container(
                        height: size.height * .2,
                        width: size.width,
                        decoration: const BoxDecoration(
                          color: AllColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(100),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, ${data['name']}!",
                                style: const TextStyle(
                                  color: AllColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                data["balance"].toString(),
                                style: const TextStyle(
                                  color: AllColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                ),
                              ),
                              const Text(
                                "Your available balance",
                                style: TextStyle(
                                  color: AllColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomMaunBottom(
                              onTap: () => homeController.sendAccount(),
                              size: size,
                              text: "Send Money",
                              icon: Icons.send,
                            ),
                            CustomMaunBottom(
                              onTap: () => homeController.addMoney(),
                              size: size,
                              text: "Add Money",
                              icon: Icons.add,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ));
      },
    );
  }
}
