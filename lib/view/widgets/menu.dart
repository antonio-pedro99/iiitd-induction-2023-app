import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/view/screens/clubs/clubs_screen.dart';
import 'package:btech_induction_2023/view/screens/home/home_screen.dart';
import 'package:btech_induction_2023/view/screens/location/location_screen.dart';
import 'package:btech_induction_2023/view/screens/schedule/schedule_screen.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/menu_button.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InductionAppMenu extends StatefulWidget {
  const InductionAppMenu({super.key});

  @override
  State<InductionAppMenu> createState() => _InductionAppMenuState();
}

class _InductionAppMenuState extends State<InductionAppMenu> {
  void _launchClubLink(String url) async {
    final encodedUrl = Uri.encodeFull(url);
    if (await canLaunch(encodedUrl)) {
      await launch(encodedUrl);
    } else {
      throw 'Could not launch $encodedUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: InductionAppColor.yellow,
      child: SafeArea(
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
                        onTap: () => _launchClubLink(
                            "https://iiitd.ac.in/life/discipline-grievance/anti-sexual-harassment-committee"),
                        image: 'icc.png',
                        margin: const EdgeInsets.only(right: 15))),
                Align(
                    alignment: Alignment.centerRight,
                    child: MenuButtonOption(
                      onTap: () =>
                          _launchClubLink("https://www.iiitd.ac.in/contact"),
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
                                onTap: () =>
                                    _launchClubLink("https://docs.google.com/spreadsheets/d/13v8l9BFTscdFjabei76bcm0W-54NaQDG6U9c-IhW2dc/edit?usp=sharing"),
                                child: const Text('Groups'),
                              ),
                              
                              InkResponse(
                                onTap: () =>
                                    _launchClubLink("https://www.iiitd.ac.in"),
                                child: const Text('About Us'),
                              ),
                              InkResponse(
                                onTap: () => context
                                    .pushReplacement(const LocationScreen()),
                                child: const Text('Location'),
                              ),
                              InkResponse(
                                onTap: () => _launchClubLink(
                                    "https://docs.google.com/spreadsheets/d/1w85BGovNseeoUiKojVfF8NYx4NBOw_5UfrIc6ALt4Yo/edit#gid=1213820881"),
                                child: const Text('FAQs'),
                              ),
                              // InkResponse(
                              //   onTap: () => _launchClubLink(""),
                              //   child: const Text('Team'),
                              // )
                              // all the text here, note: you do not need the style.
                            ]))),
              ],
            ),
          )
        ],
      )),
    );
  }
}
