import 'package:crypto_concept/src/core/presentation/ui/content_widget.dart';
import 'package:flutter/material.dart';

class OutroScreen extends StatelessWidget {
  const OutroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContentWidget(
      title: '미래를 향한 빛',
      content:
          'n.portverse 는 디지털 금융 시장에 새로운 방향을 제시합니다. n.portverse 에서 제시하는 디지털 화폐 거래방식은 사람들을 매료시키고, 새로움 금융의 길로 나아가게 할 것입니다.',
    );
  }
}
