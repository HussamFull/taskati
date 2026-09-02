import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

class Taskati extends StatelessWidget {
  const Taskati({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // يفضل إضافتها لإخفاء علامة الـ Debug
      home: SplashScreen(),
    );
  }
}