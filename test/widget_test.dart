// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo_project/state/posts/posts_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo_project/main.dart';

import 'post_controller_test.dart';

void main() {
  testWidgets('There is a list visible in a home page',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
          overrides: [postsControllerProvider.overrideWith(() => MyNotifier())],
          child: const MyApp()),
    );

    await tester.pump();
    final scaffold = find.byKey(const ValueKey('home_screen'));
    expect(scaffold, findsOneWidget);
    final list = find.byType(
      AnimatedList,
    );

    expect(list, findsOneWidget);
    await tester.pumpAndSettle();

    await tester.pumpWidget(Container());
  });

  testWidgets('list is scrollable', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
          overrides: [postsControllerProvider.overrideWith(() => MyNotifier())],
          child: const MyApp()),
    );

    await tester.pump();

    final scaffold = find.byKey(const ValueKey('home_screen'));
    expect(scaffold, findsOneWidget);

    find.byType(
      AnimatedList,
    );

    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.byKey(const Key('listTile29')), 500.0);
  });
  testWidgets('There is a dropdown in a home page',
      (WidgetTester tester) async {
    await tester.pumpWidget(UncontrolledProviderScope(
      container: ProviderContainer(),
      child: const MyApp(),
    ));
    await tester.pump();
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
}
