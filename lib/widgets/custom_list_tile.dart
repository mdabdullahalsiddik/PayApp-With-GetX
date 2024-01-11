// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  String text;
  IconData icon;
  CustomListTile({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
