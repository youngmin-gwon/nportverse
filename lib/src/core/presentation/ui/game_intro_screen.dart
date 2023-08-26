import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class GameIntroScreen extends StatefulWidget {
  const GameIntroScreen({super.key});

  @override
  State<GameIntroScreen> createState() => _GameIntroScreenState();
}

class _GameIntroScreenState extends State<GameIntroScreen>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  FragmentProgram? _shaderProgram;
  double _value = 0.0;
  Offset _mousePoint = Offset.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
    // FragmentProgram.fromAsset('assets/shaders/spherical_polyhedra.frag')
    FragmentProgram.fromAsset('assets/shaders/spherical_polyhedra.frag')
        .then((value) {
      setState(() {
        _shaderProgram = value;
      });
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsedTime) {
    setState(() {
      _value += 0.03;
    });
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

  Widget _buildShaderPainterOnLoadingState(
    Size size,
  ) {
    if (_shaderProgram == null) {
      return const SizedBox();
    } else {
      return GestureDetector(
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        child: CustomPaint(
          size: size,
          painter: MetaSpherePainter(
            shader: _shaderProgram!.fragmentShader(),
            mousePoint: _mousePoint,
            shaderSize: size,
            time: _value,
          ),
        ),
      );
    }
  }

  void onPanStart(DragStartDetails details) {
    setState(() {
      _mousePoint = details.localPosition;
    });
  }

  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _mousePoint = details.localPosition;
    });
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      _mousePoint = Offset.zero;
    });
  }
}

class MetaSpherePainter extends CustomPainter {
  MetaSpherePainter({
    super.repaint,
    required this.shader,
    required this.mousePoint,
    required this.shaderSize,
    required this.time,
  });

  final FragmentShader shader;
  final Offset mousePoint;
  final Size shaderSize;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, shaderSize.width);
    shader.setFloat(1, shaderSize.height);
    // shader.setFloat(2, mousePoint.dx);
    // shader.setFloat(3, mousePoint.dy);
    shader.setFloat(4, time);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, shaderSize.width, shaderSize.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant MetaSpherePainter oldDelegate) {
    return shader != oldDelegate.shader ||
        time != oldDelegate.time ||
        shaderSize != oldDelegate.shaderSize;
  }
}
