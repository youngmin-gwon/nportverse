import 'dart:ui';

import 'package:crypto_concept/src/core/presentation/ui/layout_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// shader 값을 받아 shader의 애니메이션을 반복하여 보여주는 [Widget].
/// 각 shader 마다 반복 주기가 다르기 때문에 무작정
/// [AnimationController] 를 사용할 수 없었습니다.
/// [AnimationController]의 low level class 인 [Ticker] 를 사용하였고,
/// tick이 발생하는 시간마다 [ValueNotifier] 값을 변경하는 방식을 선택하였습니다.
/// [ValueListenableBuilder] 가 widget tree 최상단에 존재하기 때문에 [setState] method
/// 를 사용해도 무방합니다.
class RepeatingShaderScreen extends StatefulWidget {
  const RepeatingShaderScreen({
    super.key,
    required this.shaderProgram,
  });

  final FragmentProgram shaderProgram;

  @override
  State<RepeatingShaderScreen> createState() => _RepeatingShaderScreenState();
}

class _RepeatingShaderScreenState extends State<RepeatingShaderScreen>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final ValueNotifier<double> _elapsedTime = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();

    _ticker = createTicker(_onTick)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsedTime) {
    _elapsedTime.value = _elapsedTime.value + 0.02;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ValueListenableBuilder<double>(
          valueListenable: _elapsedTime,
          builder: (context, value, child) {
            return CustomPaint(
              size: _sizeByConstraints(constraints),
              painter: ShaderPainter(
                shader: widget.shaderProgram.fragmentShader(),
                shaderSize: _sizeByConstraints(constraints),
                time: value,
              ),
            );
          });
    });
  }
}

class ShaderPainter extends CustomPainter {
  ShaderPainter({
    super.repaint,
    required this.shader,
    required this.shaderSize,
    required this.time,
  });

  final FragmentShader shader;
  final Size shaderSize;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, shaderSize.width);
    shader.setFloat(1, shaderSize.height);
    shader.setFloat(2, time);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, shaderSize.width, shaderSize.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant ShaderPainter oldDelegate) {
    return shader != oldDelegate.shader ||
        time != oldDelegate.time ||
        shaderSize != oldDelegate.shaderSize;
  }
}

/// shader 값을 받아 shader animation을 시작과 함께 1회 보여주는 [Widget]
class ForwardingShaderScreen extends StatelessWidget {
  const ForwardingShaderScreen(
      {super.key, required this.shaderProgram, required this.animation});

  final FragmentProgram shaderProgram;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return CustomPaint(
              size: _sizeByConstraints(constraints),
              painter: ShaderPainter(
                shader: shaderProgram.fragmentShader(),
                shaderSize: _sizeByConstraints(constraints),
                time: CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.0, 0.6, curve: Curves.ease),
                ).value,
              ),
            );
          });
    });
  }
}

Size _sizeByConstraints(BoxConstraints constraints) {
  return valueByScreenSize(
    constraints,
    mobile: Size(constraints.maxWidth - 30, constraints.maxWidth - 30),
    tablet: Size(constraints.maxWidth / 5 * 2, constraints.maxWidth / 5 * 2),
    desktop: Size(constraints.maxWidth / 3, constraints.maxWidth / 3),
  );
}
