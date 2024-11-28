import 'dart:async';

import 'package:flutter/material.dart';

class spleshscreen extends StatelessWidget {
  const spleshscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.pushNamed(context, "intro");
    });
    return Scaffold(
      backgroundColor: Color(0xFF0E56AB),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://i.pinimg.com/564x/3c/c3/79/3cc379679b4088a3384a5b32fe3d270e.jpg",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
