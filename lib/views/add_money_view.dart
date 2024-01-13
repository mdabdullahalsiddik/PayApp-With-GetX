import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/controller/add_money_controller.dart';
import 'package:pay/controller/internet_controller.dart';
import 'package:pay/widgets/custom_button.dart';
import 'package:pay/widgets/custom_textfromfield.dart';

class AddMoneyView extends GetView<AddMoneyController> {
  AddMoneyView({super.key});
  final AddMoneyController addMoneyController = Get.put(AddMoneyController());
  final InternetController internetController = Get.put(InternetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => addMoneyController.appBarRoute(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: GetBuilder<AddMoneyController>(
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
                  key: addMoneyController.forky,
                  child: CustomTextFromField(
                    keyboardType: TextInputType.number,
                    controller: addMoneyController.addMoneyController,
                    hintText: "Enter Money",
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Money can't be empty";
                      }
                      return null;
                    },
                  ),
                ),
                CustomButton(
                  text: "Add Money",
                  onTap:() => addMoneyController.addMoney(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
