import 'package:crypto_concept/src/core/presentation/router/main_app_router_delegate.dart';
import 'package:crypto_concept/src/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// flutter application 설정과 관련된 Widget
///
/// - [RouterDelegate] 설정
/// - [Theme] 설정
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _delegate = MainAppRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _delegate,
      backButtonDispatcher: RootBackButtonDispatcher(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
    );
  }
}
