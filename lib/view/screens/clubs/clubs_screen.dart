import 'package:btech_induction_2023/data/club.dart';
import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/view/screens/clubs/club_card.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/headline.dart';
import 'package:btech_induction_2023/view/widgets/menu.dart';
import 'package:btech_induction_2023/view/widgets/menu_icon.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:flutter/material.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const TextureBackground(),
      Align(
          alignment: Alignment.center,
          child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      forceElevated: innerBoxIsScrolled,
                      title: SizedBox(
                        child: Image.asset("images/iiitd.png", height: 200),
                      ),
                      centerTitle: true,
                      leading: InkResponse(
                          onTap: () => context.push(const InductionAppMenu()),
                          child: const MenuIcon()),
                      actions: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.sms,
                              color: InductionAppColor.yellow,
                            ))
                      ],
                    )
                  ],
              body: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const HeadlineText(text: "Clubs"),
                    const SizedBox(height: 10),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      decoration: ShapeDecoration(
                        color: InductionAppColor.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                width: 0.50,
                                color: InductionAppColor.darkGrey)),
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ClubCard(club: Club.dummyClubs()[index]);
                        },
                        itemCount: Club.dummyClubs().length,
                      ),
                    ))
                  ],
                ),
              )))
    ]));
  }
}
