import 'dart:math';

import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ShapePainter extends CustomPainter {
  double rate;

  ShapePainter({required this.rate});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.accentPrimary2
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.height / 2,
      ),
      0,
      pi * 2 * rate,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
