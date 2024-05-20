import 'dart:async';

import 'package:adasae/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // CustomPaint(
          //   size: Size(MediaQuery.of(context).size.width, 200),
          //   painter: MyPainter(),
          // ),
          Column( mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 50,),
          Positioned(
            top: 50,
            right: 50,
            child: Text(
              'Adasae',
              style: GoogleFonts.outfit(
                  color: Colors.lightGreen.shade900,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 50,),
          const Positioned(
            bottom: 50,
            right: 50,
            child: SpinKitDoubleBounce(color: Colors.lightGreen, size: 50),
          ),])
        ],
      ),
    );
  }
}

// class MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..shader = LinearGradient(
//         colors: [
//           Color.fromARGB(255, 146, 163, 93),
//           Color.fromARGB(255, 202, 215, 131),
//         ],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
//       ..style = PaintingStyle.fill;

//     Path path = Path()
//       ..moveTo(0, 0)
//       ..lineTo(0, size.height * 0.8)
//       ..quadraticBezierTo(size.width * 0.25, size.height, size.width * 0.5, size.height * 0.8)
//       ..quadraticBezierTo(size.width * 0.75, size.height * 0.6, size.width, size.height * 0.8)
//       ..lineTo(size.width, 0)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
