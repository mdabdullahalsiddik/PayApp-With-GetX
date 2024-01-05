import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/controller/login_controller.dart';

import 'package:pay/static/all%20colors/all_colors.dart';
import 'package:pay/static/all%20texts/all_texts.dart';
import 'package:pay/views/authentication/register_view.dart';
import 'package:pay/widgets/custom_button.dart';
import 'package:pay/widgets/custom_textfromfield.dart';

// ignore: must_be_immutable, camel_case_types
class loginView extends StatelessWidget {
  loginView({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // PasswordController passController = Get.put(PasswordController());
  LoginController loginController = Get.put(LoginController());
  var forky = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Scaffold(body: GetBuilder<LoginController>(
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
                          "Login to your account",
                          style: TextStyle(
                            color: AllColors.primaryColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Form(
                          key: forky,
                          child: Column(
                            children: [
                              CustomTextFromField(
                                controller: loginController.emailController,
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
                                controller: loginController.passwordController,
                                obscureText: loginController.passwordValidator,
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
                                    loginController.setPasswordValidator();
                                  },
                                  icon: Icon(
                                    loginController.passwordValidator == true
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
                          text: "Login",
                          onTap: () {
                            if (forky.currentState!.validate()) {
                              loginController.setTextField();
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(RegisterView());
                          },
                          child: const Text(
                            "Register",
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
      )),
    );
  }
}
