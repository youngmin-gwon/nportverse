import 'package:crypto_concept/src/core/presentation/ui/game_intro_screen.dart';
import 'package:crypto_concept/src/core/presentation/ui/start_screen.dart';
import 'package:flutter/material.dart';

class StartPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const StartScreen(),
    );
  }
}

class GameIntroPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const GameIntroScreen(),
    );
  }
}
