// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pay/static/all%20colors/all_colors.dart';

// ignore: must_be_immutable
class CustomMaunBottom extends StatelessWidget {
  String text;
  IconData icon;
  void Function()? onTap;
  CustomMaunBottom({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * .15,
        width: size.width * .3,
        decoration: const BoxDecoration(
          color: AllColors.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AllColors.whiteColor,
            ),
            Text(
              text,
              style: const TextStyle(
                color: AllColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
