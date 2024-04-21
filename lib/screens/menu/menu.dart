import 'package:flame_audio/flame_audio.dart';
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
import 'package:plastic_punk/state/game/levels/levels.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  bool _showLevels = false;
  AudioPlayer? _audioPlayer;
  bool _playMusic = false;
  bool _showIntro = false;
  Level? _selectedLevel;
  String? _selectedSlot;

  @override
  void initState() {
    super.initState();
    FlameAudio.loopLongAudio('intro.mp3', volume: 0.2).then((player) {
      if (!mounted) {
        player.stop();
        return;
      }
      _audioPlayer = player;
      if (_playMusic) {
        _audioPlayer?.resume();
      } else {
        _audioPlayer?.pause();
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shouldPlayMusic = ModalRoute.of(context)?.isCurrent == true;
    if (shouldPlayMusic != _playMusic) {
      _playMusic = shouldPlayMusic;
      if (_playMusic) {
        _audioPlayer?.resume();
      } else {
        _audioPlayer?.pause();
      }
    }

    if (_showIntro) {
      return IntroScreen(onSkip: () {
        final level = _selectedLevel ?? Levels.levels.first;
        _start(context, level: level, slot: _selectedSlot);
      });
    }

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

    if (!introShown) {
      setState(() {
        _selectedLevel = level;
        _selectedSlot = slot;
        _showIntro = true;
      });
      return;
    }

    _selectedLevel = null;
    _selectedSlot = null;

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => GameScreen(loadSlot: slot, level: level),
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
    ).then((value) => _showIntro = false);
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
