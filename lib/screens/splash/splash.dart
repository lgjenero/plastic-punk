import 'package:flutter/material.dart';
import 'package:plastic_punk/screens/menu/menu.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      _menu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizeLayoutBuilder(
        small: (context, child) => _buildLayout(context, child, SizeLayout.small),
        medium: (context, child) => _buildLayout(context, child, SizeLayout.medium),
        large: (context, child) => _buildLayout(context, child, SizeLayout.large),
      ),
    );
  }

  Widget _buildLayout(BuildContext context, Widget? child, SizeLayout size) {
    return Center(
      child: Image.asset(
        'assets/images/app_assets/icon.png',
        width: AppSizes.splashIcon(size).width,
        height: AppSizes.splashIcon(size).height,
      ),
    );
  }

  void _menu() {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const MenuScreen(),
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
      (route) => false,
    );
  }
}
