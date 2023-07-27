import 'package:btech_induction_2023/data/event.dart';
import 'package:btech_induction_2023/data/user.dart';
import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/service/firebase.dart';
import 'package:btech_induction_2023/view/screens/home/event_tile.dart';
import 'package:btech_induction_2023/view/screens/profile/profile_screen.dart';
import 'package:btech_induction_2023/view/widgets/headline.dart';
import 'package:btech_induction_2023/view/widgets/menu.dart';
import 'package:btech_induction_2023/view/widgets/menu_icon.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InductionAppHomePage extends StatelessWidget {
  const InductionAppHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          const TextureBackground(),
          Align(
              alignment: Alignment.center,
              child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userProfile = UserProfile.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                    return NestedScrollView(
                        floatHeaderSlivers: true,
                        headerSliverBuilder: (context, innerBoxIsScrolled) => [
                              SliverAppBar(
                                forceElevated: innerBoxIsScrolled,
                                title: SizedBox(
                                  child: Image.asset("images/iiitd.png",
                                      height: 200),
                                ),
                                centerTitle: true,
                                leading: InkResponse(
                                    onTap: () =>
                                        context.push(const InductionAppMenu()),
                                    child: const MenuIcon()),
                                actions: [
                                  InkResponse(
                                    onTap: () {
                                      context.push(ProfilePage(
                                          userProfile: userProfile));
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: userProfile.profileImage != null
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                   userProfile.profileImage!),
                                              )
                                            : const CircleAvatar(
                                                child: Icon(Icons.person))),
                                  )
                                ],
                              )
                            ],
                        body: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              const HeadlineText(text: "events"),
                              const SizedBox(height: 10),
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: Event.items().length,
                                      itemBuilder: (context, index) =>
                                          EventTile(
                                            event: Event.items()[index],
                                          ))),
                            ],
                          ),
                        ));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
        ],
      ),
    ));
  }
}
