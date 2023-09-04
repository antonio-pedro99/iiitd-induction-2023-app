import 'package:btech_induction_2023/data/user.dart'; // Replace this with the actual implementation of the UserProfile class
import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/extensions/system.dart';
import 'package:btech_induction_2023/service/firebase.dart';
import 'package:btech_induction_2023/view/screens/login/login_screen.dart';
import 'package:btech_induction_2023/view/screens/profile/create_profile_screen.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/custom_card.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/headline.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        if (mounted) {
          context.pushAndRemoveUntil(const LoginScreen());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: Image.asset("images/iiitd.png", height: 200),
        ),
        centerTitle: true,
        actions: const [
          SizedBox(
            width: 50,
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const Positioned.fill(
            child:
                TextureBackground(), // Replace this with the actual TextureBackground widget
          ),
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<DocumentSnapshot?>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userProfile = UserProfile.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>);
                  return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: kTextTabBarHeight * 2),
                          const HeadlineText(text: 'My Profile'),
                          const SizedBox(height: 18),
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 100,
                                    left: context.width * 0.025,
                                    right: 0,
                                    bottom: 0,
                                    child:
                                        const CascadeCard(child: SizedBox())),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: DefaultTextStyle(
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Netflix Sans ',
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.48,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: 300,
                                          height: 300,
                                          alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 155,
                                                top: 0,
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(0.0, 0.0)
                                                    ..rotateZ(0.79),
                                                  child: Container(
                                                    width: 234.76,
                                                    height: 234.76,
                                                    decoration: ShapeDecoration(
                                                      color: InductionAppColor
                                                          .yellow,
                                                      image:
                                                          const DecorationImage(
                                                        image: AssetImage(
                                                            'images/bg_texture.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      shape: const OvalBorder(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 32.28,
                                                top: 42.28,
                                                child: Container(
                                                  width: 234.76,
                                                  height: 234.76,
                                                  decoration: ShapeDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          userProfile
                                                              .profileImage!),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    shape: const OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkResponse(
                                          onTap: () => context.push(
                                              CreateProfileScreen(
                                                  currentUser: userProfile)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.edit, size: 12),
                                              const SizedBox(width: 4),
                                              Text(
                                                userProfile.username!,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          userProfile.fullName,
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          userProfile.rollNumber!,
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: InductionAppColor.yellow,
                                                width: .5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.transparent,
                                          ),
                                          child: Text(
                                            'Points: ${userProfile.points}',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          MaterialButton(
                              onPressed: () {
                                Provider.of<FirebaseAuthService>(context,
                                        listen: false)
                                    .signOut();
                              },
                              child: const Text("Logout"))
                        ],
                      ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
