import 'dart:math';

import 'package:flutter/material.dart';

class WaveProgress extends StatefulWidget {
  final Color waveColor;
  final double progress;
  const WaveProgress(
      {super.key, required this.waveColor, required this.progress});

  @override
  State<WaveProgress> createState() => _WaveProgressState();
}

class _WaveProgressState extends State<WaveProgress>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    animationController?.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, child) {
        return CustomPaint(
            painter: WaveProgressPainter(
                animationController, widget.waveColor, widget.progress));
      },
    );
  }
}

class WaveProgressPainter extends CustomPainter {
  final Animation<double>? _animation;
  final Color color;
  final double _progress;
  WaveProgressPainter(this._animation, this.color, this._progress)
      : super(repaint: _animation);
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint wave1 = Paint()..color = color.withOpacity(.5);
    double p = _progress / 100;
    double n = 1.5;
    double amp = 2.0;
    double baseHeight = (1 - p) * size.height;
    Path path = Path();
    path.moveTo(0, baseHeight);
    for (double i = 0; i < size.width; i++) {
      path.lineTo(
          i,
          baseHeight +
              sin((i / size.width * 2 * pi * n) +
                      (_animation!.value * 2 * pi) +
                      pi * 1) *
                  amp);
    }
    path.lineTo(size.width, baseHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, wave1);

    Paint wave2 = Paint()..color = color;
    n = 1.5;
    amp = 3.0 * size.height / 180;
    path = Path();
    path.moveTo(0, baseHeight);
    for (double i = 0; i < size.width; i++) {
      path.lineTo(
          i,
          baseHeight +
              sin((i / size.width * 2 * pi * n) +
                      (_animation!.value * 2 * pi)) *
                  amp);
    }
    path.lineTo(size.width, baseHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, wave2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
