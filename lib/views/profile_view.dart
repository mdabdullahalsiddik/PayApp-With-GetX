// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/controller/profile_controller.dart';
import 'package:pay/static/all%20colors/all_colors.dart';
import 'package:pay/widgets/custom_button.dart';
import 'package:pay/widgets/custom_textfromfield.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  final ProfileController profileController = Get.put(ProfileController());
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
      child: GetBuilder<ProfileController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Scaffold(
              body: SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          profileController.pickedImage == null
                              ? const CircleAvatar(
                                  radius: 70,
                                  backgroundColor: AllColors.primaryColor,
                                  backgroundImage:
                                      AssetImage("assets/images/profile.png"),
                                )
                              : CircleAvatar(
                                  radius: 70,
                                  backgroundColor: AllColors.primaryColor,
                                  backgroundImage:
                                      FileImage(profileController.pickedImage!),
                                ),
                          Container(
                            decoration: BoxDecoration(
                              color: AllColors.whiteColor,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: AllColors.primaryColor,
                              ),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AboutDialog(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                profileController
                                                    .cameraPickImage();
                                                Navigator.pop(context);
                                              },
                                              child: const ListTile(
                                                leading: Icon(
                                                  Icons.camera_alt,
                                                ),
                                                title: Text("Camera"),
                                              )),
                                          InkWell(
                                              onTap: () async {
                                                await profileController
                                                    .galleryPickImage();
                                                Navigator.pop(context);
                                              },
                                              child: const ListTile(
                                                leading: Icon(
                                                  Icons.image,
                                                ),
                                                title: Text("Gallery"),
                                              )),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                          ),
                        ],
                      ),
                      Form(
                          key: profileController.forky,
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * .01,
                              ),
                              CustomTextFromField(
                                controller: profileController.nameController,
                                hintText: "Enter Full name",
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Name can't be empty";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              CustomTextFromField(
                                controller: profileController.phoneController,
                                hintText: "Enter phone number",
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Phone number can't be empty";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              CustomTextFromField(
                                controller: profileController.nidController,
                                hintText: "Enter nid number",
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "nid number can't be empty";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              CustomTextFromField(
                                controller: profileController.birthController,
                                hintText: "Enter birth date (yyyy-mm-dd)",
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Birth date (yyyy-mm-dd) can't be empty";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              CustomButton(
                                text: "Save",
                                onTap: () async {
                                  await profileController.sendImage();
                                  profileController.setProfile();
                                },
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
