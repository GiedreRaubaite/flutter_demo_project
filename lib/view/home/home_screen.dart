import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo_project/state/router/posts/posts_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final appState = ref.watch(appStateControllerProvider);
    final list = ref.watch(postsControllerProvider);
    print('list $list');
    return Scaffold(
        appBar: AppBar(
          title: const Text('ListView Example'),
        ),
        body: list.when(
          data: (data) {
            print('data ${data.length}');
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text('Item ${index + 1}'),
                  subtitle: Text('${data[index].title}'),
                  onTap: () {
                    // Action to perform when the ListTile is tapped
                    print('Tapped on item ${index + 1}');
                  },
                );
              },
            );
          },
          error: (error, stackTrace) {
            return ErrorWidget(stackTrace);
          },
          loading: () {
            return const Text('loading');
          },
        ));
  }
}
