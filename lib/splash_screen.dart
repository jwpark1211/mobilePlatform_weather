import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main.dart';

/*로딩 화면입니다.*/
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Get.off(() => const MainScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012677), // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 5), // Spacer to push the logo down
            Image.asset(
              'assets/images/cloud.png', // Logo image
              width: 200,
              height: 200,
            ),
            const Spacer(flex: 10), // Spacer to push the text down
            const Text(
              '오늘날씨', // Title text
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 5), // Spacer to push everything to the center
          ],
        ),
      ),
    );
  }
}
