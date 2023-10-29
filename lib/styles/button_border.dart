import 'package:flutter/material.dart';

class ButtonBorder extends OutlinedBorder {
  final bool positive;
  final double borderRadius;
  final int points;
  final ColorScheme colorScheme;

  /// List of 4 values for each corner: top left, top right, bottom right, bottom left
  final List<bool> roundedCorners;

  const ButtonBorder({
    required this.positive,
    required this.borderRadius,
    required this.points,
    required this.colorScheme,
    this.roundedCorners = const [true, true, true, true],
  });
  ({Path path, Paint paint}) customBorderPathPaint(Rect rect) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, rect.width, rect.height),
      topLeft: roundedCorners[0] ? Radius.circular(borderRadius) : Radius.zero,
      topRight: roundedCorners[1] ? Radius.circular(borderRadius) : Radius.zero,
      bottomRight: roundedCorners[2] ? Radius.circular(borderRadius) : Radius.zero,
      bottomLeft: roundedCorners[3] ? Radius.circular(borderRadius) : Radius.zero,
    ));

    return (path: path, paint: paint);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final ({Path path, Paint paint}) pathPaint = customBorderPathPaint(rect);

    canvas.drawPath(pathPaint.path, pathPaint.paint);
  }

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    return this;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return customBorderPathPaint(rect).path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return customBorderPathPaint(rect).path;
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}
