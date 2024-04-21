import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/game.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/saves_dialog.dart';
import 'package:plastic_punk/screens/intro/intro.dart';
import 'package:plastic_punk/screens/menu/widgets/level_selector.dart';
import 'package:plastic_punk/screens/menu/widgets/menu_content.dart';
import 'package:plastic_punk/screens/menu/widgets/profile_button.dart';
import 'package:plastic_punk/services/user/user_service.dart';
import 'package:plastic_punk/state/game/levels/level.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  bool _showLevels = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(child: Image.asset('assets/images/app_assets/splash.webp', fit: BoxFit.cover)),
        if (!_showLevels)
          Positioned.fill(
              child: MenuContent(
            onStartGameTap: () => setState(() => _showLevels = true),
            onContinueGameTap: () => _continue(context),
          )),
        if (_showLevels)
          Positioned.fill(
              child: LevelSelector(
            onBack: () => setState(() => _showLevels = false),
            onLevelSeleced: (level) {
              _start(context, level: level);
            },
          )),
        const Positioned(
          top: 8,
          right: 8,
          child: SafeArea(child: ProfileButton()),
        )
      ],
    ));
  }

  void _start(BuildContext context, {required Level level, String? slot}) {
    final introShown = ref.read(userServiceProvider).userData.introShown;

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => slot != null
            ? GameScreen(loadSlot: slot, level: level)
            : introShown
                ? GameScreen(level: level)
                : IntroScreen(level: level),
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

  void _continue(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          Widget buildDialog(SizeLayout size) => SavesDialog(
              size: size,
              showEmpty: false,
              onBack: () => Navigator.pop(context),
              onSelect: (slot, level) {
                if (level == null) return;
                Navigator.pop(context);
                _start(context, slot: slot, level: level);
              });

          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: SizeLayoutBuilder(
                small: (_, __) => buildDialog(SizeLayout.small),
                medium: (_, __) => buildDialog(SizeLayout.medium),
                large: (_, __) => buildDialog(SizeLayout.large),
              ),
            ),
          );
        });
  }
}
