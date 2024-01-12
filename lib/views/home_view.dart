// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/home_controller.dart';
import 'package:pay/controller/internet_controller.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/static/all%20colors/all_colors.dart';
import 'package:pay/widgets/custom_manu_bottom.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final homeController = Get.put(HomeController());
  final InternetController internetController = Get.put(InternetController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
          title: "Exit",
          titleStyle: const TextStyle(color: Colors.red),
          middleText: "Are you sure?",
          onConfirm: () {
            exit(0);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );

        return false;
      },
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return Scaffold(
              drawer: StreamBuilder(
                stream: FirebaseAllFunction.userCollection
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
                              FirebaseAllFunction.user,
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
                actions: [
                  Image.asset(
                    "assets/images/icon.png",
                  ),
                ],
              ),
              body: StreamBuilder(
                stream: FirebaseAllFunction.userCollection.snapshots(),
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
                                  "${data["balance"].toString()} Taka",
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
                          child: Wrap(
                            spacing: 10,
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
                        Expanded(
                            child: StreamBuilder(
                          stream: FirebaseAllFunction.historyStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                primary: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index];
                                  bool isMeSender = data["sender"] ==
                                      FirebaseAllFunction.user;
                                  bool isMeReceiver = data["receiver"] ==
                                      FirebaseAllFunction.user;
                                  return isMeSender || isMeReceiver
                                      ? ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: AllColors.primaryColor,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  isMeSender
                                                      ? data["receiver_image"]
                                                          .toString()
                                                      : data["sender_image"]
                                                          .toString(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            isMeSender
                                                ? data["receiver_name"]
                                                    .toString()
                                                : data["sender_name"]
                                                    .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          subtitle: Text(
                                            isMeSender
                                                ? data["receiver"].toString()
                                                : data["sender"].toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          trailing: isMeReceiver
                                              ? Text(
                                                  "+ ${data["amount"].toString()} Taka",
                                                  style: const TextStyle(
                                                    color: AllColors.greenColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                )
                                              : Text(
                                                  "- ${data["amount"].toString()} Taka",
                                                  style: const TextStyle(
                                                    color: AllColors.redColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                        )
                                      : const SizedBox();
                                },
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ))
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ));
        },
      ),
    );
  }
}
