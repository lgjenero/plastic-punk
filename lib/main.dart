import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/splash/splash.dart';
import 'package:plastic_punk/utils/platform.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();
  if (isMobile) await Flame.device.setLandscape();

  runApp(const ProviderScope(
      child: MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  )));
}
