import 'package:crypto_concept/src/core/presentation/ui/content_widget.dart';
import 'package:flutter/material.dart';

class GameIntroScreen extends StatelessWidget {
  const GameIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContentWidget(
      title: '게임',
      content:
          'n.portverse 는 새로운 방식의 금융 서비스를 제안합니다. 바로 NFT 게임과 금융을 결합하는 것이죠.\nCasual Game 부터 Metaverse Game 까지 영역을 확대해나갑니다.',
    );
  }
}
