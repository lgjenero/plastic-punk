import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Represents the layout size passed to [SizeLayoutBuilder.child].
enum SizeLayout {
  /// Small layout
  small,

  /// Medium layout
  medium,

  /// Large layout
  large,
}

/// Signature for the individual builders (`small`, `medium`, `large`).
typedef SizeLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

/// {@template platform_layout_builder}
/// A wrapper around [LayoutBuilder] which exposes builders for
/// various responsive breakpoints.
/// {@endtemplate}
class SizeLayoutBuilder extends StatelessWidget {
  /// {@macro platform_layout_builder}
  const SizeLayoutBuilder({
    Key? key,
    required this.small,
    required this.medium,
    required this.large,
    this.child,
  }) : super(key: key);

  /// [SizeLayoutWidgetBuilder] for small layout.
  final SizeLayoutWidgetBuilder small;

  /// [SizeLayoutWidgetBuilder] for medium layout.
  final SizeLayoutWidgetBuilder medium;

  /// [SizeLayoutWidgetBuilder] for large layout.
  final SizeLayoutWidgetBuilder large;

  /// Optional child widget builder based on the current platform
  /// which will be passed to the `small`, `medium` and `large` builders
  /// as a way to share/optimize shared layout.
  final Widget Function(SizeLayout currentSize)? child;

  @override
  Widget build(BuildContext context) {
    final defaultTargetSize = of(context);
    switch (defaultTargetSize) {
      case SizeLayout.small:
        return small(context, child?.call(SizeLayout.small));
      case SizeLayout.medium:
        return medium(context, child?.call(SizeLayout.medium));
      case SizeLayout.large:
        return large(context, child?.call(SizeLayout.large));
    }
  }

  static SizeLayout of(BuildContext context) {
    final screenWidth = math.min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return screenWidth < 400
        ? SizeLayout.small
        : screenWidth < 800
            ? SizeLayout.medium
            : SizeLayout.large;
  }
}
