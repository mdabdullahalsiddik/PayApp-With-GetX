import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/send_money_controller.dart';
import 'package:pay/function/data.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/static/all%20colors/all_colors.dart';
import 'package:pay/widgets/custom_button.dart';
import 'package:pay/widgets/custom_textfromfield.dart';

class SendMoneyView extends StatelessWidget {
  SendMoneyView({super.key});
  final SendMoneyController sendMoneyController =
      Get.put(SendMoneyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: GetBuilder<SendMoneyController>(
          builder: (controller) {
            return StreamBuilder(
              stream: FirebaseAllFunction.firestore
                  .collection("user")
                  .doc(receiverMail)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.data()!;
                  return Column(
                    children: [
                      Column(
                        children: [
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
                          ),
                          CustomTextFromField(
                            controller: sendMoneyController.amountController,
                            hintText: "Amount",
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      CustomButton(
                        text: "Send",
                        onTap: () {
                          sendMoneyController.setSend();
                        },
                      )
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          },
        ));
  }
}
