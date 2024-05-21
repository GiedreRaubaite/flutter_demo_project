import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/state/router/route_names.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  List<RouteBase> routes = [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: Routes.homeRouteName,
      path: Routes.homeRoute,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: Routes.postDetailsRouteName,
      path: Routes.postDetailsRoute,
      builder: (context, state) =>
          PostDetailScreen(post: state.extra as PostVM),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: Routes.errorPopUpRouteName,
      path: Routes.errorPopUpRoute,
      builder: (context, state) => const Dialog(
        child: Text("Oops, something went wrong"),
      ),
    ),
  ];

  final router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: Routes.homeRoute,
      debugLogDiagnostics: kDebugMode,
      routes: routes,
      errorBuilder: _errorRoute);

  return router;
}

Widget _errorRoute(BuildContext context, GoRouterState state) {
  if (state.extra == null || state.extra is! String) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        iconTheme: const IconThemeData(),
      ),
      body: Center(
        child: Text(
          'Wrong arguments for route ${state.name}',
        ),
      ),
    );
  }
  return Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
      iconTheme: const IconThemeData(),
    ),
    body: Center(
      child: Text(
        state.extra! as String,
      ),
    ),
  );
}
