import 'package:flutter/material.dart';
import 'dart:math' as Math;

class TimerPainter extends CustomPainter {
  final twoPi = 2 * Math.pi;

  final start = Math.pi * 1.5;

  final Animation<double> animation;
  Color ringColor;
  double ringStroke;

  TimerPainter({this.animation, this.ringColor, this.ringStroke})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final sweep = twoPi * (1 - animation.value);
    final radius = Math.min(size.width, size.height) / 2;

    final Paint paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringStroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(size.center(Offset.zero), radius, paint);

    Rect rect =
        Rect.fromCircle(center: size.center(Offset.zero), radius: radius);
    paint.color = ringColor;
    canvas.drawArc(rect, start, sweep, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value;
  }
}
