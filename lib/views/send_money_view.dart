import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/send_money_controller.dart';
import 'package:pay/function/data.dart';
import 'package:pay/function/firebase_function.dart';
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
                          Form(
                            key: sendMoneyController.forky,
                            child: CustomTextFromField(
                              controller: sendMoneyController.amountController,
                              hintText: "Amount",
                              keyboardType: TextInputType.number,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "Amount can't be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          StreamBuilder(
                            stream: FirebaseAllFunction.firestore
                                .collection("user")
                                .doc(FirebaseAllFunction.auth.currentUser!.email
                                    .toString())
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data1 = snapshot.data!.data()!;
                                return Text(
                                    "Available Balance: ${data1['balance']}");
                              }
                              return const CircularProgressIndicator();
                            },
                          )
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
