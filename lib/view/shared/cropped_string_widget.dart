import 'package:flutter/widgets.dart';

class CroppedString extends StatelessWidget {
  const CroppedString({super.key, required this.text, required this.maxLength});

  final String? text;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Text(text != null
        ? text!.length > maxLength
            ? '${text!.substring(0, maxLength)}...'
            : text!
        : '');
  }
}
