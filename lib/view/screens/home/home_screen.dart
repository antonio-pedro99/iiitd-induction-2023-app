import 'package:btech_induction_2023/data/event.dart';
import 'package:btech_induction_2023/data/user.dart';
import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/extensions/system.dart';
import 'package:btech_induction_2023/service/firebase.dart';
import 'package:btech_induction_2023/view/screens/home/event_tile.dart';
import 'package:btech_induction_2023/view/screens/profile/profile_screen.dart';
import 'package:btech_induction_2023/view/widgets/headline.dart';
import 'package:btech_induction_2023/view/widgets/menu.dart';
import 'package:btech_induction_2023/view/widgets/menu_icon.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

class InductionAppHomePage extends StatelessWidget {
  const InductionAppHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const InductionAppMenu(),
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
                        final userProfile = UserProfile.fromJson(
                            snapshot.data!.data() as Map<String, dynamic>);
                        return NestedScrollView(
                            floatHeaderSlivers: true,
                            headerSliverBuilder: (context,
                                    innerBoxIsScrolled) =>
                                [
                                  SliverAppBar(
                                    forceElevated: innerBoxIsScrolled,
                                    title: SizedBox(
                                      child: Image.asset("images/iiitd.png",
                                          height: 200),
                                    ),
                                    centerTitle: true,
                                    leading: InkResponse(
                                        onTap: () => context.openDrawer(),
                                        child: const MenuIcon()),
                                    actions: [
                                      InkResponse(
                                        onTap: () {
                                          context.push(const ProfilePage());
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: userProfile.profileImage !=
                                                    null
                                                ? SizedBox(
                                                    width: 50,
                                                    child: CircleAvatar(
                                                      radius: 50,
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: userProfile
                                                                .profileImage!,
                                                            fit: BoxFit.fill,
                                                            width: 100,
                                                            placeholder: (context,
                                                                    url) =>
                                                                Center(
                                                                    child:
                                                                        LiquidCircularProgressIndicator()),
                                                          )),
                                                    ),
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
                                      child: FutureBuilder<List<Event>>(
                                          future: Provider.of<
                                                      FirebaseFirestoreService>(
                                                  context)
                                              .getEvents(),
                                          builder: (context, snapshot) {
                                            print(snapshot.data);
                                            if (snapshot.hasData) {
                                              return ListView.builder(
                                                  itemCount:
                                                      snapshot.data!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return EventTile(
                                                        event: snapshot
                                                            .data![index]);
                                                  });
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                child: Text(
                                                    "Something went wrong"),
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          })),
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
