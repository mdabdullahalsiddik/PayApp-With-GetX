import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pay/function/firebase_function.dart';

class FirebaseController extends GetxController {
  var data;
  var c;
  // @override
  // void onInit() {
  //   super.onInit();
  //   setFirebase();
  // }

  setFirebase() {
    FirebaseAllFunction.firestore
        .collection("user")
        .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
        .get();

    update();
  }

  getData() {
    FirebaseAllFunction.firestore
        .collection("user")
        .doc(FirebaseAllFunction.auth.currentUser!.email.toString())
        .get()
        .then((value) {
      data = value.data();
    });
  }
}
