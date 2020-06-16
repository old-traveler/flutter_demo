import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

class LineChart extends StatelessWidget {
  final List<double> values;
  final double strokeWidth;
  final Size size;

  const LineChart({Key key, this.values, this.strokeWidth: 3, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LineChartPainter(values, strokeWidth),
      size: Size(size.width, size.height + strokeWidth),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> chartItems;
  final double strokeWidth;

  LineChartPainter(this.chartItems, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    double step = size.width / (chartItems.length - 1);
    Path path = Path();
    Path linePath = Path();
    double chartHeight = size.height - strokeWidth;
    double maxValue = chartItems.reduce((value, item) => max(value, item));
    List<double> values = chartItems
        .map<double>((item) => item / maxValue * chartHeight)
        ?.toList(growable: false);
    chartHeight = size.height;
    path.moveTo(0, chartHeight);
    path.lineTo(0, chartHeight - values.first);
    linePath.moveTo(0, chartHeight - values.first);
    for (int i = 1; i < values.length; i++) {
      double startX1 = (i - 1) * step;
      double startY1 = chartHeight - values[i - 1];
      double startX2 = i * step;
      double startY2 = chartHeight - values[i];
      path.cubicTo(
          (startX1 + startX2) / 2,
          startY1, // control point 1
          (startX1 + startX2) / 2,
          startY2, //  control point 2
          startX2,
          startY2);
      linePath.cubicTo(
          (startX1 + startX2) / 2,
          startY1, // control point 1
          (startX1 + startX2) / 2,
          startY2, //  control point 2
          startX2,
          startY2);
    }
    path.lineTo((values.length - 1) * step, chartHeight);
    path.close();

    var paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    paint.shader =
        ui.Gradient.linear(Offset.zero, Offset(0, chartHeight), <Color>[
      Color(0xFFEDF9F4),
      Color(0xFFF7FFFC),
      Color(0x00EDF9F4),
    ], <double>[
      0.3333,
      0.7777,
      1.0
    ]);
    canvas.drawPath(path, paint);

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = ui.Gradient.linear(Offset(0, chartHeight / 2),
          Offset((values.length - 1) * step, chartHeight / 2), <Color>[
        Color(0x5600A75B),
        Color(0xFF00A75B),
        Color(0xFF00A75B),
        Color(0x5600A75B),
        Color(0x0000A75B),
      ], <double>[
        0.2,
        0.4,
        0.6,
        0.8,
        1.0
      ]);
    canvas.drawPath(linePath, paint);
  }

  @override
  bool shouldRepaint(LineChartPainter oldDelegate) {
    return chartItems != oldDelegate.chartItems;
  }
}
