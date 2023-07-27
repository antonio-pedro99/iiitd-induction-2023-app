import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/view/screens/home/home_screen.dart';
import 'package:btech_induction_2023/view/screens/profile/create_profile_screen.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          const TextureBackground(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FractionallySizedBox(
                    child: Image.asset("images/logo.png"),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                      color: InductionAppColor.yellow,
                      onPressed: () =>
                          context.push(const CreateProfileScreen()),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Sign in with Google"),
                          SizedBox(width: 10),
                          Icon(Icons.login)
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
