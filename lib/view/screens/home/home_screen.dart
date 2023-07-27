import 'package:btech_induction_2023/data/event.dart';
import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/view/screens/home/event_tile.dart';
import 'package:btech_induction_2023/view/screens/location/location_screen.dart';
import 'package:btech_induction_2023/view/screens/schedule/schedule_screen.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/headline.dart';
import 'package:btech_induction_2023/view/widgets/menu.dart';
import 'package:btech_induction_2023/view/widgets/menu_icon.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:flutter/material.dart';

class InductionAppHomePage extends StatefulWidget {
  const InductionAppHomePage({Key? key}) : super(key: key);

  @override
  State<InductionAppHomePage> createState() => _InductionAppHomePageState();
}

class _InductionAppHomePageState extends State<InductionAppHomePage> {
  final List<Event> events = Event.items();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
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
                              onTap: () =>
                                  context.push(const InductionAppMenu()),
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
                        const HeadlineText(text: "events"),
                        const SizedBox(height: 10),
                        Expanded(
                            child: ListView.builder(
                                itemCount: events.length,
                                itemBuilder: (context, index) => EventTile(
                                      event: events[index],
                                    ))),
                      ],
                    ),
                  ))),
        ],
      ),
    ));
  }
}
