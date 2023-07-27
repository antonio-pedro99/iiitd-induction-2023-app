import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          const TextureBackground(),
          Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              child: Image.asset(
                "images/logo.png",
                height: 200,
                width: 200,
              ),
            ),
          )
        ],
      )),
    );
  }
}
