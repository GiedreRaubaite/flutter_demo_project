// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_demo_project/main.dart';

void main() {
  testWidgets('There is a dropdown in a home page',
      (WidgetTester tester) async {
    await tester.pumpWidget(UncontrolledProviderScope(
      container: ProviderContainer(),
      child: const MyApp(),
    ));

    final dropDownWidget = find.byKey(const ValueKey('dropdown'));

    expect(dropDownWidget, findsOneWidget);
  });
  testWidgets(
      'Dropdown initial value is the same as the initial language of a device',
      (WidgetTester tester) async {
    await tester.pumpWidget(UncontrolledProviderScope(
      container: ProviderContainer(),
      child: const MyApp(),
    ));
    List<String> languages = ["en", "nl"];
    var languageOfADevice = languages.firstWhere(
        (element) => element == Platform.localeName.substring(0, 2));
    final dropDownWidget = find.byKey(const ValueKey('dropdown'));
    expect(
        tester.widget(dropDownWidget),
        isA<DropdownButton>().having(
          (s) => s.hint!.key,
          'value',
          ValueKey('hint$languageOfADevice'),
        ));
  });

  testWidgets('DropdownButton change languages control',
      (WidgetTester tester) async {
    await tester.pumpWidget(UncontrolledProviderScope(
      container: ProviderContainer(),
      child: const MyApp(),
    ));
    final dropDownWidget = find.byKey(const ValueKey('dropdown'));
    await tester.tap(dropDownWidget);
    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    final dropdownItem = find.byKey(
      const ValueKey('nl'),
    );
    final dropdownItem2 = find.byKey(
      const ValueKey('en'),
    );
    await tester.tap(dropdownItem);
    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    expect(dropdownItem, findsOneWidget);
    expect(dropdownItem2, findsNothing);
  });
}
