import 'package:crypto_concept/src/core/presentation/router/main_app_configuration.dart';
import 'package:crypto_concept/src/core/presentation/router/pages.dart';
import 'package:flutter/material.dart';

class MainAppRouterDelegate extends RouterDelegate<MainAppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  MainAppRouterDelegate() : _navigatorKey = GlobalKey();

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: [
        // StartPage(),
        GameIntroPage(),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;

        return true;
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
