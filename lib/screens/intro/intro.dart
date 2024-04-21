import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/game.dart';
import 'package:plastic_punk/services/user/user_service.dart';
import 'package:plastic_punk/state/game/levels/level.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/times.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class IntroScreen extends ConsumerStatefulWidget {
  final Level level;
  const IntroScreen({super.key, required this.level});

  static const List<_IntroSlide> _slides = [
    _IntroSlide(
      '1',
      'assets/images/app_assets/intro/slide_1.webp',
      'In a world brimming with wealth and development, consumerism reigns supreme. Busy streets and shops bustle with activity, as people indulge in the pleasure of buying more than they need.',
    ),
    _IntroSlide(
      '2',
      'assets/images/app_assets/intro/slide_2.webp',
      'But this overconsumption comes at a steep price. Our once pristine natural environments are now choked with the remnants of our excess — mountains of discarded plastics that tarnish the beauty of nature',
    ),
    _IntroSlide(
      '3',
      'assets/images/app_assets/intro/slide_3.webp',
      'The neglect has led us to a gloomy and depressing reality. Plastic waste dominates every corner of our world, from the cities we inhabit to the natural landscapes we once cherished. The urgency for change has never been greater.',
    ),
  ];

  @override
  ConsumerState<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed((3 * AppTimes.introSlideDurationMs).ms, () {
      if (!mounted) return;
      _skip(context);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(userServiceProvider.notifier).setIntroShown();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizeLayoutBuilder(
      small: (context, child) => _buildLayout(context, child, SizeLayout.small),
      medium: (context, child) => _buildLayout(context, child, SizeLayout.medium),
      large: (context, child) => _buildLayout(context, child, SizeLayout.large),
    );
  }

  Widget _buildLayout(BuildContext context, Widget? child, SizeLayout size) {
    final slideWidgets = IntroScreen._slides.mapIndexed(
      (index, slide) {
        return Positioned.fill(
          child: _IntroSlideWidget(size, slide)
              .animate()
              .fadeIn(
                duration: AppTimes.introSlideTransitionDurationMs.ms,
                delay: (AppTimes.introSlideDurationMs * index).ms,
              )
              .then(delay: (AppTimes.introSlideDurationMs - 2 * AppTimes.introSlideTransitionDurationMs).ms)
              .fadeOut(duration: AppTimes.introSlideTransitionDurationMs.ms),
        );
      },
    ).toList();

    return Scaffold(
      backgroundColor: AppColors.introBackground,
      body: Stack(
        children: [
          ...slideWidgets,
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              bottom: false,
              left: false,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.buttonBackground,
                  foregroundColor: AppColors.buttonForeground,
                  textStyle: AppFonts.button(size),
                ),
                onPressed: () => _skip(context),
                child: const Text('Skip'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _skip(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => GameScreen(level: widget.level),
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var fadeAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
      ),
    );
  }
}

class _IntroSlide {
  final String id;
  final String image;
  final String message;

  const _IntroSlide(this.id, this.image, this.message);
}

class _IntroSlideWidget extends StatelessWidget {
  final SizeLayout size;
  final _IntroSlide slide;

  const _IntroSlideWidget(this.size, this.slide);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(slide.id),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: Image.asset(slide.image, fit: BoxFit.cover)),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              slide.message,
              style: AppFonts.introText(size).copyWith(color: AppColors.introForeground),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
        ),
      ],
    );
  }
}
