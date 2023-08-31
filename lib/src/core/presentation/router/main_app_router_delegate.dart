import 'package:crypto_concept/src/core/presentation/router/main_app_configuration.dart';
import 'package:crypto_concept/src/core/presentation/router/pages.dart';
import 'package:flutter/material.dart';

/// OS 로 화면을 변경하라는 명령을 받아 이를 어느 화면으로 가야할지 처리하는 class
///
/// 현재는 간단하게 [HomeScreen] 으로만 갈 수 있게 처리 되어있음
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
        HomePage(),
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
