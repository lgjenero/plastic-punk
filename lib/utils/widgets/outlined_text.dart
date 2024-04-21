import 'package:flutter/widgets.dart';

/// Places a stroke around text to make it appear outlined
///
/// Adapted from https://stackoverflow.com/a/55559435/11846040
class OutlinedText extends StatelessWidget {
  /// Text to display
  final String text;

  /// Original text style (if you weren't outlining)
  ///
  /// Do not specify `color` inside this: use [textColor] instead.
  final TextStyle style;

  /// Text color
  final Color textColor;

  /// Outline stroke color
  final Color strokeColor;

  /// Outline stroke width
  final double strokeWidth;

  /// Text alignment
  final TextAlign? textAlign;

  /// Places a stroke around text to make it appear outlined
  ///
  /// Adapted from https://stackoverflow.com/a/55559435/11846040
  const OutlinedText(
    this.text, {
    super.key,
    this.style = const TextStyle(),
    required this.textColor,
    required this.strokeColor,
    required this.strokeWidth,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(foreground: Paint()..color = textColor),
          textAlign: textAlign,
        ),
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..strokeWidth = strokeWidth
              ..color = strokeColor
              ..style = PaintingStyle.stroke,
          ),
          textAlign: textAlign,
        ),
      ],
    );
  }
}
