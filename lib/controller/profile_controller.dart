import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/views/home_view.dart';
import 'package:pay/views/navigator/bottom_navigator.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  File? pickedImage;
  String? images;
  cameraPickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      final tempImage = File(image!.path);
      pickedImage = tempImage;
    } catch (e) {
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
          "${FirebaseAllFunction.auth.currentUser!.email.toString().replaceAll('.', '')}_${dataKye.toString()}",
        )
        .putFile(pickedImage!);

    images = await imagePath.ref.getDownloadURL();
    update();
  }

  setProfile() async {
    await FirebaseAllFunction.firestore
        .collection("user")
        .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
        .set({
      "name": nameController.text,
      "phone": phoneController.text,
      "nid": nidController.text,
      "birthday": birthController.text,
      "mail": FirebaseAllFunction.auth.currentUser!.email,
      "image": images,
      "balance": 2000,
      "token": await FirebaseAllFunction.messaging.getToken(),
    });
    Get.offAll(const BottomNavigatorView());
    Get.snackbar("Successful", "Account set is successful");
    update();
  }
}
