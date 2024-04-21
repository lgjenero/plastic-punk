import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class FlagWidget extends StatefulWidget {
  final String countryCode;
  final SizeLayout size;

  const FlagWidget({required this.countryCode, required this.size, super.key});

  @override
  State<FlagWidget> createState() => _FlagWidgetState();
}

class _FlagWidgetState extends State<FlagWidget> {
  SpriteAnimation? _animation;
  SpriteAnimationTicker? _ticker;

  @override
  void initState() {
    super.initState();
    _loadSprite();
  }

  @override
  void didUpdateWidget(covariant FlagWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countryCode != widget.countryCode) {
      _loadSprite();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_animation == null || _ticker == null) return const SizedBox.shrink();

    return SizedBox(
      width: AppSizes.messageFlag(widget.size).width,
      height: AppSizes.messageFlag(widget.size).height,
      child: SpriteAnimationWidget(
        animation: _animation!,
        animationTicker: _ticker!,
        anchor: Anchor.center,
      ),
    );
  }

  void _loadSprite() async {
    final image = await Flame.images.load('flags/${widget.countryCode}.png');
    if (!mounted) return;

    final animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.variable(
        amount: 16,
        stepTimes: List.generate(16, (index) => 0.1),
        textureSize: Vector2(192, 136),
        amountPerRow: 4,
      ),
    );

    setState(() {
      _animation = animation;
      _ticker = animation.createTicker();
    });
  }
}
