import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/internet_controller.dart';
import 'package:pay/controller/send_account_controller.dart';
import 'package:pay/widgets/custom_button.dart';
import 'package:pay/widgets/custom_textfromfield.dart';

class SendAccountView extends GetView<SendAccountController> {
  SendAccountView({super.key});
  final SendAccountController sendAccountController =
      Get.put(SendAccountController());
  final InternetController internetController = Get.put(InternetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => sendAccountController.setBack(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: GetBuilder<SendAccountController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: sendAccountController.forky,
                  child: CustomTextFromField(
                    controller: sendAccountController.mailController,
                    hintText: "Enter account mail",
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Mail can't be empty";
                      }
                      return null;
                    },
                  ),
                ),
                CustomButton(
                  text: "Next",
                  onTap:() => sendAccountController.setData(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
