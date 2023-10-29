import 'package:flutter/material.dart';
import 'package:hobiti/constants.dart';

class ButtonPainter extends CustomPainter {
  final bool positive;
  final double borderRadius;
  final int points;
  final ColorScheme colorScheme;

  /// List of 4 values for each corner: top left, top right, bottom right, bottom left
  final List<bool> roundedCorners;

  ButtonPainter({
    required this.positive,
    required this.borderRadius,
    required this.points,
    required this.colorScheme,
    this.roundedCorners = const [true, true, true, true],
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = positive ? Constants.positiveColor : colorScheme.errorContainer;

    final path = Path();
    path.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topLeft: roundedCorners[0] ? Radius.circular(borderRadius) : Radius.zero,
      topRight: roundedCorners[1] ? Radius.circular(borderRadius) : Radius.zero,
      bottomRight: roundedCorners[2] ? Radius.circular(borderRadius) : Radius.zero,
      bottomLeft: roundedCorners[3] ? Radius.circular(borderRadius) : Radius.zero,
    ));

    canvas.drawPath(path, paint);

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: "${positive ? "+" : ""}$points",
        style: TextStyle(
          fontSize: Constants.nameFontSize,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(canvas, Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
