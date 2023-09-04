import 'package:btech_induction_2023/data/club.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubCard extends StatelessWidget {
  const ClubCard({super.key, required this.club});
  final Club club;

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
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: double.infinity,
      height: 200,
      child: Row(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: InductionAppColor.yellow,
                  height: 90,
                  width: 90,
                  child: GestureDetector(
                    onTap: () {
                      _launchClubLink(club
                          .siteLink); // Replace 'club.link' with the actual URL you want to open
                    },
                    child: Image.asset(
                      "images/clubs/" + club.imagePath,
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  color: InductionAppColor.yellow,
                  height: 110,
                  width: 20,
                ),
              ),
            ],
          ),
          Expanded(
            // Use Expanded to make the Column take all remaining space
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align text to the left
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(club.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Netflix Sans ',
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Add some spacing between the texts
                  Expanded(
                    // Use Expanded for multi-line wrapping
                    child: Text(club.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Netflix Sans ',
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.46,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
