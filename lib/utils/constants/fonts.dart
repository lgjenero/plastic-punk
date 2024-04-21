import 'package:flutter/material.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class AppFonts {
  static TextStyle title(SizeLayout size) {
    return TextStyle(
      fontFamily: '04B_30',
      fontSize: size == SizeLayout.small
          ? 48
          : size == SizeLayout.medium
              ? 56
              : 64,
    );
  }

  static TextStyle level(SizeLayout size) {
    return TextStyle(
      fontFamily: '04B_30',
      fontSize: size == SizeLayout.small
          ? 24
          : size == SizeLayout.medium
              ? 30
              : 42,
    );
  }

  static TextStyle introText(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Teko',
      fontSize: size == SizeLayout.small
          ? 22
          : size == SizeLayout.medium
              ? 24
              : 28,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle button(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Teko',
      fontSize: size == SizeLayout.small
          ? 24
          : size == SizeLayout.medium
              ? 32
              : 48,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle hud(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Teko',
      fontSize: size == SizeLayout.small
          ? 18
          : size == SizeLayout.medium
              ? 20
              : 24,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle messageTitle(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Teko',
      fontSize: size == SizeLayout.small
          ? 22
          : size == SizeLayout.medium
              ? 24
              : 28,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle messageBody(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Teko',
      fontSize: size == SizeLayout.small
          ? 20
          : size == SizeLayout.medium
              ? 22
              : 26,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle messageLink(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Teko',
      fontSize: size == SizeLayout.small
          ? 20
          : size == SizeLayout.medium
              ? 22
              : 26,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle tooltip(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Teko',
      fontSize: size == SizeLayout.small
          ? 16
          : size == SizeLayout.medium
              ? 18
              : 20,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle onboardingTooltip(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Teko',
      fontSize: size == SizeLayout.small
          ? 16
          : size == SizeLayout.medium
              ? 18
              : 20,
      fontWeight: FontWeight.w600,
    );
  }
}

extension TextStyleUtils on TextStyle {
  Size getTextSize(String text, {double minWidth = 0.0, double maxWidth = double.infinity}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: this),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.size;
  }
}
