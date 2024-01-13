// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/internet_controller.dart';
import 'package:pay/controller/success_controller.dart';
import 'package:pay/function/data.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/static/all%20colors/all_colors.dart';
import 'package:pay/widgets/custom_button.dart';

class SuccessView extends GetView<SuccessController> {
  SuccessView({super.key});
  final InternetController internetController = Get.put(InternetController());
  final SuccessController successController = Get.put(SuccessController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        successController.back();

        return false;
      },
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAllFunction.firestore
              .collection("user")
              .doc(receiverMail)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!.data()!;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: AllColors.greenColor,
                          size: 20,
                        ),
                        const Text(
                          "Successfully Send",
                          style: TextStyle(
                            color: AllColors.greenColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(data["image"].toString()),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                          ),
                          title: Text(
                            data["name"].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            data["mail"].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: Text(
                            " $sendMoney Taka",
                            style: const TextStyle(
                              color: AllColors.greenColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        CustomButton(
                          text: "Done",
                          onTap:() => successController.back(),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
