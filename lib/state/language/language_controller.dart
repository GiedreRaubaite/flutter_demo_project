import 'dart:io';
import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_controller.g.dart';

@riverpod
class LanguageController extends _$LanguageController {
  @override
  Locale build() {
    return Locale.fromSubtags(languageCode: Platform.localeName);
  }

  void setLocale(String lang) {
    state = Locale.fromSubtags(languageCode: lang);
  }
}
