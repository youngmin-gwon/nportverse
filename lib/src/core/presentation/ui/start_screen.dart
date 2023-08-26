import 'dart:ui';

import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  FragmentProgram? _shaderProgram;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    FragmentProgram.fromAsset('assets/shaders/atmospheric_scattering.frag')
        .then((value) {
      setState(() {
        _shaderProgram = value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return _buildShaderPainterOnLoadingState(
                const Size(300, 300),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShaderPainterOnLoadingState(Size size) {
    if (_shaderProgram == null) {
      return const SizedBox();
    } else {
      return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: size,
              painter: AtmosphericSpherePainter(
                time: CurvedAnimation(
                        parent: _controller, curve: Curves.easeInOut)
                    .value,
                shader: _shaderProgram!.fragmentShader(),
                shaderSize: size,
              ),
            );
          });
    }
  }
}

class AtmosphericSpherePainter extends CustomPainter {
  const AtmosphericSpherePainter(
      {required this.shader, required this.time, required this.shaderSize});
  final FragmentShader shader;
  final Size shaderSize;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, shaderSize.width);
    shader.setFloat(1, shaderSize.height);
    shader.setFloat(2, time);
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, shaderSize.width, shaderSize.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant AtmosphericSpherePainter oldDelegate) {
    return time != oldDelegate.time;
  }
}
