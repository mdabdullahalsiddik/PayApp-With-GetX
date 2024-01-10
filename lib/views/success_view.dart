import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pay/function/data.dart';
import 'package:pay/function/firebase_function.dart';
import 'package:pay/static/all%20colors/all_colors.dart';
import 'package:pay/views/home_view.dart';
import 'package:pay/views/navigator/bottom_navigator.dart';
import 'package:pay/widgets/custom_button.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAllFunction.firestore
            .collection("user")
            .doc(receiverMail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.data()!;
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AllColors.greenColor,
                    ),
                    const Text(
                      "Successfully Send",
                      style: TextStyle(
                        color: AllColors.greenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
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
                      trailing: Text(
                        " $sendMoney",
                        style: const TextStyle(
                          color: AllColors.greenColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    CustomButton(
                      text: "Done",
                      onTap: () {
                        Get.to(const BottomNavigatorView());
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
