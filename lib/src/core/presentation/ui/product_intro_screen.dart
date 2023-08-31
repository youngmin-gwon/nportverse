import 'package:crypto_concept/src/core/presentation/ui/content_widget.dart';
import 'package:flutter/material.dart';

class ProductIntroScreen extends StatelessWidget {
  const ProductIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContentWidget(
      title: '초월적 경험',
      content:
          '결제를 위해 왜 인터넷이 필요해야할까요? 여러가지 보안프로그램을 설치하고도 왜 불안 해야할까요?\nn.portverse 를 통한 CBDC 거래는 여태까지 경험하지 못한 안전하고, 인터넷이 필요없는 초월적 경험을 제공합니다.',
    );
  }
}
