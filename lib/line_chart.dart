import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class LineChart extends StatelessWidget {
  final double step;
  final List<double> values;
  final double strokeWidth;

  const LineChart({Key key, this.step: 12, this.values, this.strokeWidth: 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LineChartPainter(step, values, strokeWidth),
      size: Size(step * (values.length + 1),
          values.reduce((value, e) => max(value, e)) + 2.5 * step),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final double step;
  final List<double> values;
  final double strokeWidth;

  LineChartPainter(this.step, this.values, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    double chartHeight = size.height - 1.5 * step;
    path.moveTo(0, chartHeight);
    for (int i = 0; i < values.length; i++) {
      path.lineTo(i * step, chartHeight - values[i]);
    }
    Path newPath = Path();
    newPath.arcTo(
        Rect.fromCircle(
            center: Offset(values.length * step, chartHeight - values.last),
            radius: step),
        pi / 2,
        pi / 2,
        false);
    newPath.lineTo(values.length * step, chartHeight);
    path.lineTo(values.length * step, chartHeight);
    path.close();
    path.addPath(newPath, Offset.zero);

    var paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    paint.shader =
        ui.Gradient.linear(Offset.zero, Offset(0, chartHeight), <Color>[
      Color(0xFFEF9A9A),
      Color(0xFFFFCDD2),
      Color(0xFFFFEBEE),
    ], <double>[
      0.3333,
      0.7777,
      1.0
    ]);
    canvas.drawPath(path, paint);

    paint.strokeWidth = strokeWidth;
    paint.shader = null;
    Color targetColor = Colors.red;
    for (int i = 1; i < values.length; i++) {
      paint.style = PaintingStyle.stroke;
      paint.color =
          targetColor.withAlpha(55 + i * (200.0 ~/ (values.length - 1)));
      final start = Offset((i - 1) * step, chartHeight - values[i - 1]);
      final end = Offset(i * step, chartHeight - values[i]);
      canvas.drawLine(start, end, paint);
      paint.style = PaintingStyle.fill;
      canvas.drawRect(
          Rect.fromLTWH((i - 1) * step, size.height - step, step / 2, step / 2),
          paint);
    }
    canvas.drawRect(
        Rect.fromLTWH(
            (values.length - 1) * step, size.height - step, step / 2, step / 2),
        paint);
    paint.strokeWidth = strokeWidth;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(values.length * step, chartHeight - values.last), step, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
