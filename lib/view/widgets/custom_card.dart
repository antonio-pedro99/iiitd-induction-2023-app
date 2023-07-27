import 'package:btech_induction_2023/extensions/system.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:flutter/material.dart';

class CascadeCard extends StatelessWidget {
  const CascadeCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the desired height as a percentage of the screen height
    double desiredHeight = screenHeight * 0.7;

    return SizedBox(
      width: 310,
      height: desiredHeight,
      child: Stack(
        children: [
          Positioned(
            left: 9,
            top: 13,
            child: Container(
              width: 301,
              height: desiredHeight,
              decoration: ShapeDecoration(
                color: InductionAppColor.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.19),
                ),
              ),
            ),
          ),
          Positioned(
            left: 9,
            top: 13,
            child: SizedBox(
              width: 301,
              height: desiredHeight,
              child: Image.asset(
                "images/bg_texture.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 1,
            child: Container(
              width: 301,
              height: desiredHeight,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: const Color(0xFF252525),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.10),
                  borderRadius: BorderRadius.circular(6.19),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 0.83,
                    offset: Offset(0, 0.83),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
