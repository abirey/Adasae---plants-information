// import 'package:adasae/view/detail_page.dart';
// import 'package:adasae/view/fav_page.dart';
import 'package:adasae/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SplashScreen()
        
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => DetailScreen(plantData: null,),
      //   '/favorites': (context) => FavoritePage(),
      // },
    );
  }
}
