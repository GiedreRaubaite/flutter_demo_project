import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/state/router/route_names.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> _shellNavigatorKey =
//     GlobalKey<NavigatorState>();

// final RouteObserver<ModalRoute<void>> rootRouteObserver =
//     RouteObserver<ModalRoute<void>>();
// final RouteObserver<ModalRoute<void>> shellRouteObserver =
//     RouteObserver<ModalRoute<void>>();

final routerProvider = Provider<GoRouter>(name: 'Router Provider', (ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.startRoute,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: router,
    routes: router._routes,
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref);
  final Ref _ref;

  List<RouteBase> get _routes => [
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: RouteName.startRouteName,
          path: RouteName.startRoute,
          builder: (context, state) => const HomeScreen(),
        ),
      ];

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
}
