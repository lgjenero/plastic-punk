import 'package:flutter/material.dart';
import 'package:plastic_punk/screens/intro/intro.dart';
import 'package:plastic_punk/screens/menu/widgets/menu_content.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(child: Image.asset('assets/images/app_assets/splash.webp', fit: BoxFit.cover)),
        Positioned.fill(
            child: MenuContent(
          onStartGameTap: () => _start(context),
        )),
      ],
    ));
  }

  void _start(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const IntroScreen(),
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
