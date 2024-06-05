import 'package:flutter/material.dart';
import 'main.dart';

/*로딩 화면입니다.*/
class SplashScreen extends StatefulWidget {
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
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF012677), // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 5), // Spacer to push the logo down
            Image.asset(
              'assets/images/cloud.png', // Logo image
              width: 200,
              height: 200,
            ),
            Spacer(flex: 10), // Spacer to push the text down
            Text(
              '오늘날씨', // Title text
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(flex: 5), // Spacer to push everything to the center
          ],
        ),
      ),
    );
  }
}