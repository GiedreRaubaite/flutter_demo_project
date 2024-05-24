import 'package:flutter/material.dart';

class PopUpWidget extends StatelessWidget {
  const PopUpWidget({super.key, required this.text, required this.icon});

  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.none),
          ),
        ),
      ],
    ));
  }
}
