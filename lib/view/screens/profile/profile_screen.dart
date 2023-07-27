import 'package:btech_induction_2023/data/user.dart'; // Replace this with the actual implementation of the UserProfile class
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/custom_card.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../widgets/headline.dart';

class ProfilePage extends StatelessWidget {
  final UserProfile? userProfile;

  const ProfilePage({this.userProfile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const Positioned.fill(
            child:
                TextureBackground(), // Replace this with the actual TextureBackground widget
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: kTextTabBarHeight),
                  const HeadlineText(text: 'My Profile'),
                  const SizedBox(height: 30),
                  CascadeCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: [
                            userProfile!.profileImage != null
                                ? CircleAvatar(
                                    radius: 100,
                                    backgroundImage: NetworkImage(
                                        userProfile!.profileImage!),
                                  )
                                : const CircleAvatar(
                                    radius: 100, child: Icon(Icons.person))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userProfile!.username,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          userProfile!.fullName,
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: InductionAppColor.yellow, width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          child: Text(
                            'Points: ${userProfile!.points}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
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
