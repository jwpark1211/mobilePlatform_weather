import 'package:flutter/material.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText1 = '여행';
  final String titleText2 = '을 떠나볼까요?';

  const WeatherAppBar({super.key});

  void _navigateToBookmark() {
    // Implement navigation to bookmark page
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text.rich(TextSpan(children: [
        TextSpan(
          text: ' $titleText1',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF012677),
          ),
        ),
        TextSpan(
          text: titleText2,
          style: const TextStyle(
            color: Color(0xFF012677),
            fontSize: 20,
          ),
        ),
      ])),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: IconButton(
            icon: Icon(Icons.menu, color: Colors.blue[900]),
            onPressed: _navigateToBookmark,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}