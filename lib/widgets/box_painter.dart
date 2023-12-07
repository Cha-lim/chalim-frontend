import 'package:chalim/models/box.dart';
import 'package:flutter/material.dart';

class BoxPainter extends CustomPainter {
  final List<Box> boxes;

  BoxPainter({required this.boxes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    for (var box in boxes) {
      // Assuming each box has 4 points: top-left, top-right, bottom-right, bottom-left
      var path = Path();
      path.moveTo(box.points[0][0].toDouble(), box.points[0][1].toDouble());
      for (var i = 1; i < box.points.length; i++) {
        path.lineTo(box.points[i][0].toDouble(), box.points[i][1].toDouble());
      }
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
