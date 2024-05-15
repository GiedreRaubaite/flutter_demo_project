import 'package:flutter/widgets.dart';
import 'package:flutter_demo_project/state/router/_router.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:go_router/go_router.dart';

class HomeRouter {
  const HomeRouter({
    required this.parentKey,
  });
  final GlobalKey<NavigatorState> parentKey;
  GoRoute get baseRoute => GoRoute(
        parentNavigatorKey: parentKey,
        name: Routes.homeRouteName,
        path: Routes.homeRoute,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            name: Routes.postDetailsRouteName,
            path: Routes.postDetailsRoute,
            builder: (context, state) => PostDetailScreen(
              post: state.extra as PostVM,
            ),
          ),
        ],
      );
}
