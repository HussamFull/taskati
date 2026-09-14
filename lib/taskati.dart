


import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

  ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);


class Taskati extends StatelessWidget {
   Taskati({super.key});


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,

      builder: (context, themeMode, child) {
        return MaterialApp(
          
          debugShowCheckedModeBanner: false,

          themeMode: themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white

           ),
           darkTheme:ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black

           ),

           

            home: SplashScreen(),
        
        
        
        );
      },
    );

   
  }
}
