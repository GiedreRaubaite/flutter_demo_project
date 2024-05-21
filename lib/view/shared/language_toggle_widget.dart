import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo_project/state/language/language_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LanguageToggleWidget extends ConsumerWidget {
  const LanguageToggleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String>? languages = ["en", "nl"];
    return SizedBox(
      width: 100,
      height: 40,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: languages[0],
          onChanged: (value) async {
            if (value != null) {
              ref.read(languageControllerProvider.notifier).setLocale(value);
            }
          },
          dropdownColor: const Color.fromARGB(255, 88, 88, 88),
          icon: const Icon(
            FontAwesomeIcons.angleDown,
            color: Color.fromARGB(255, 88, 88, 88),
            size: 16,
          ),
          items: languages.map(
            (e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            },
          ).toList(),
          hint: DropdownMenuItem(
            child: Text(languages[0]),
          ),
        ),
      ),
    );
  }
}
