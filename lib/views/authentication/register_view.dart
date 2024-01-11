import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/controller/register_controller.dart';
import 'package:pay/static/all%20colors/all_colors.dart';
import 'package:pay/static/all%20texts/all_texts.dart';
import 'package:pay/views/authentication/login_view.dart';
import 'package:pay/widgets/custom_button.dart';
import 'package:pay/widgets/custom_textfromfield.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Scaffold(
        body: GetBuilder<RegisterController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image.asset("assets/images/icon.png"),
                          AllTexts.logoText,
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Register Here",
                            style: TextStyle(
                              color: AllColors.primaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Form(
                            key: registerController.forky,
                            child: Column(
                              children: [
                                CustomTextFromField(
                                  controller:
                                      registerController.emailController,
                                  hintText: "Enter Email",
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return "Email can't be empty";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                CustomTextFromField(
                                  controller:
                                      registerController.passwordController,
                                  obscureText:
                                      registerController.passwordValidator,
                                  textInputAction: TextInputAction.done,
                                  hintText: "Enter Password",
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return "Password can't be empty";
                                    }
                                    return null;
                                  },
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      registerController.setPasswordValidator();
                                    },
                                    icon: Icon(
                                      registerController.passwordValidator ==
                                              true
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AllColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          CustomButton(
                            text: "Register",
                            onTap: () {
                              registerController.setTextField();
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: AllColors.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(loginView());
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: AllColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
