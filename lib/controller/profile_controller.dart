// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/navigator/bottom_navigator.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  var forky = GlobalKey<FormState>();
  File? pickedImage;
  String? images;
  cameraPickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      final tempImage = File(image!.path);
      pickedImage = tempImage;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  galleryPickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      final tempImage = File(image!.path);
      pickedImage = tempImage;
    } catch (e) {
      print(e);
    }
    update();
  }

  Future sendImage() async {
    var dataKye = DateTime.now().microsecond;

    var imagePath = await FirebaseAllFunction.storage
        .ref("user")
        .child(
          "${FirebaseAllFunction.user.replaceAll('.', '')}_${dataKye.toString()}",
        )
        .putFile(pickedImage!);

    images = await imagePath.ref.getDownloadURL();
    update();
  }

  setProfile() async {
    if (forky.currentState!.validate()) {
      try {
        await EasyLoading.show(status: 'loading...');
        await FirebaseAllFunction.firestore
            .collection("user")
            .doc(FirebaseAllFunction.user)
            .set({
          "name": nameController.text,
          "phone": phoneController.text,
          "nid": nidController.text,
          "birthday": birthController.text,
          "mail": FirebaseAllFunction.user,
          "image": images,
          "balance": 0,
          "token": await FirebaseAllFunction.messaging.getToken(),
        });
        Get.offAll(BottomNavigatorView());
        Get.snackbar("Successful", "Account set is successful");
        EasyLoading.dismiss();
      } catch (e) {
        Get.snackbar("Error", "$e");
      }
    }
    update();
  }
   dialog(context) {
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
    update();
  }
}
