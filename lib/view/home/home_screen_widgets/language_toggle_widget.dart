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
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
        child: SizedBox(
          width: 50,
          height: 20,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              key: const ValueKey('dropdown'),
              value: chosenLanguage,
              onChanged: (value) async {
                if (value != null) {
                  setState(() {
                    chosenLanguage = value;
                  });
                  ref
                      .read(languageControllerProvider.notifier)
                      .setLocale(value);
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
                    key: ValueKey(e),
                    value: e,
                    child: Text(e.toUpperCase()),
                  );
                },
              ).toList(),
              hint: DropdownMenuItem(
                key: ValueKey("hint$chosenLanguage"),
                value: chosenLanguage,
                child: Text(chosenLanguage ?? 'en'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
