import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green[800];
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.45);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.3,
        size.width * 0.3, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.7, 0,
        size.width * 9.0, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}