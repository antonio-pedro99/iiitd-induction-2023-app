import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/service/firebase.dart';
import 'package:btech_induction_2023/view/screens/clubs/clubs_screen.dart';
import 'package:btech_induction_2023/view/screens/home/home_screen.dart';
import 'package:btech_induction_2023/view/screens/location/location_screen.dart';
import 'package:btech_induction_2023/view/screens/login/login_screen.dart';
import 'package:btech_induction_2023/view/screens/schedule/schedule_screen.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/menu_button.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InductionAppMenu extends StatefulWidget {
  const InductionAppMenu({super.key});

  @override
  State<InductionAppMenu> createState() => _InductionAppMenuState();
}

class _InductionAppMenuState extends State<InductionAppMenu> {
  @override
  initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        if (mounted) {
          context.pushReplacement(const LoginScreen());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InductionAppColor.yellow,
      body: SafeArea(
          child: Stack(
        children: [
          const TextureBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'MENU',
                      style: TextStyle(
                          fontSize: 81,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: MenuButtonOption(
                        onTap: () =>
                            context.pushReplacement(const ScheduleScreen()),
                        image: "schedule.png",
                        margin: const EdgeInsets.only(left: 15, top: 3))),
                Align(
                    alignment: Alignment.centerRight,
                    child: MenuButtonOption(
                      onTap: () => context.pushReplacement(const ClubsScreen()),
                      image: 'club.png',
                      margin: const EdgeInsets.only(right: 15),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: MenuButtonOption(
                        onTap: () {},
                        image: 'v_tour.png',
                        margin: const EdgeInsets.only(right: 15))),
                Align(
                    alignment: Alignment.centerRight,
                    child: MenuButtonOption(
                      onTap: () {},
                      image: 'contact.png',
                      margin: const EdgeInsets.only(right: 15),
                    )),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: DefaultTextStyle(
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkResponse(
                                onTap: () => context.pushReplacement(
                                    const InductionAppHomePage()),
                                child: const Text('Home'),
                              ),
                              InkResponse(
                                onTap: () {},
                                child: const Text('About Us'),
                              ),
                              InkResponse(
                                onTap: () => context
                                    .pushReplacement(const LocationScreen()),
                                child: const Text('Location'),
                              ),
                              InkResponse(
                                onTap: () {},
                                child: const Text('FAQs'),
                              ),
                              InkResponse(
                                onTap: () {
                                  Provider.of<FirebaseAuthService>(context,
                                          listen: false)
                                      .signOut();
                                },
                                child: const Text('Logout'),
                              )
                              // all the text here, note: you do not need the style.
                            ]))),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
