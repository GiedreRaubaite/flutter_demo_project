import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo_project/state/language/language_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LanguageToggleWidget extends ConsumerStatefulWidget {
  const LanguageToggleWidget({super.key});

  @override
  ConsumerState<LanguageToggleWidget> createState() => _LanguageToggleWidget();
}

class _LanguageToggleWidget extends ConsumerState<LanguageToggleWidget> {
  List<String> languages = ["en", "nl"];

  late String? chosenLanguage;

  @override
  void initState() {
    chosenLanguage = languages.firstWhere(
        (element) => element == Platform.localeName.substring(0, 2));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26),
      child: SizedBox(
        width: 40,
        height: 40,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: chosenLanguage,
            onChanged: (value) async {
              if (value != null) {
                setState(() {
                  chosenLanguage = value;
                });
                ref.read(languageControllerProvider.notifier).setLocale(value);
              }
            },
            dropdownColor: const Color.fromARGB(255, 255, 255, 255),
            icon: const Icon(
              FontAwesomeIcons.angleDown,
              color: Color.fromARGB(255, 88, 88, 88),
              size: 16,
            ),
            items: languages.map(
              (e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.toUpperCase()),
                );
              },
            ).toList(),
            hint: DropdownMenuItem(
              child: Text(languages[0]),
            ),
          ),
        ),
      ),
    );
  }
}
