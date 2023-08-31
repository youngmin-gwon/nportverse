import 'package:crypto_concept/src/core/presentation/ui/layout_constant.dart';
import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Align(
        alignment: valueByScreenSize<Alignment>(
          constraints,
          mobile: const Alignment(0, 0.9),
          tablet: const Alignment(-0.3, 0.9),
          desktop: const Alignment(0.6, 0),
        ),
        child: SizedBox(
          width: valueByScreenSize(constraints,
              mobile: constraints.maxWidth - 80,
              tablet: constraints.maxWidth - 60,
              desktop: constraints.maxWidth / 3),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  content,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
