import 'package:crypto_concept/src/core/presentation/ui/layout_constant.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key, required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: const Interval(0.7, 1, curve: Curves.easeInOut),
        ),
        child: Align(
          alignment: valueByScreenSize(constraints,
              mobile: const Alignment(0.0, 0.9),
              tablet: const Alignment(0.0, 0.8),
              desktop: const Alignment(0.0, 0.8)),
          child: SizedBox(
            width: valueByScreenSize(constraints,
                mobile: constraints.maxWidth - 100,
                tablet: constraints.maxWidth - 50,
                desktop: constraints.maxWidth / 2),
            child: Text.rich(
              TextSpan(
                text: '금융의 새로운 미래를 만들어 갑니다.\n',
                children: [
                  TextSpan(
                    text: 'CBDC',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const TextSpan(
                    text: ', ',
                  ),
                  TextSpan(
                    text: 'Blockchain',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const TextSpan(
                    text: ', ',
                  ),
                  TextSpan(
                    text: 'NFT',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const TextSpan(
                    text: ' 등의 기술로\n 차세대 공유 경제 시장의 중심이 될 것입니다.',
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }
}
