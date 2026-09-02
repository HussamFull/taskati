import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // يمكنك تعديل تصميم شاشة الترحيب هنا لم اعمله حت الفيدو 2 / محاضرة 5 
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'), // تصميم شاشة الترحيب الخاصة بك
      ),
    );
  }
}