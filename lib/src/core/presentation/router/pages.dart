import 'package:crypto_concept/src/core/presentation/ui/home_screen.dart';
import 'package:flutter/material.dart';

/// [RouterDelegate] 에서 사용하는 class
///
/// - 어느 Widget을 보여주는지, 어떠한 transition 효과를 주는지 정의할 수 있음
class HomePage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const HomeScreen(),
    );
  }
}
