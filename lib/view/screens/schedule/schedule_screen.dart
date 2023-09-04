import 'package:btech_induction_2023/data/step_info.dart';
import 'package:btech_induction_2023/extensions/system.dart';
import 'package:btech_induction_2023/view/screens/schedule/schedule_page.dart';
import 'package:btech_induction_2023/view/screens/schedule/tab_changer.dart';
import 'package:btech_induction_2023/view/widgets/headline.dart';
import 'package:btech_induction_2023/view/widgets/menu.dart';
import 'package:btech_induction_2023/view/widgets/menu_icon.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late PageController pageController;
  int currentDay = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentDay);
    pageController.addListener(() {
      setState(() {
        currentDay = pageController.page!.toInt();
      });
    });
  }

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
                child: NestedScrollView(
                    floatHeaderSlivers: true,
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          SliverAppBar(
                            forceElevated: innerBoxIsScrolled,
                            title: SizedBox(
                              child:
                                  Image.asset("images/iiitd.png", height: 200),
                            ),
                            centerTitle: true,
                            leading: InkResponse(
                                onTap: () => context.openDrawer(),
                                child: const MenuIcon()),
                            actions: const [
                              SizedBox(
                                width: 50,
                              ),
                            ],
                          )
                        ],
                    body: SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const HeadlineText(text: "schedule"),
                          const SizedBox(height: 10),
                          TabChanger(
                            pageController: pageController,
                            selectedDay: currentDay + 1,
                            onNext: () {
                              if (currentDay < 2) {
                                pageController.animateToPage(currentDay + 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              }
                            },
                            onPrevious: () {
                              if (currentDay > 0) {
                                pageController.animateToPage(currentDay - 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                              child: FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection("schedules")
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return PageView.builder(
                                          controller: pageController,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            if (snapshot.hasData) {
                                              final schedule =
                                                  snapshot.data!.docs[index];
                                              return FutureBuilder(
                                                  future: schedule.reference
                                                      .collection("activities")
                                                      .get(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return PageSchedule(
                                                          schedules: snapshot
                                                              .data!.docs
                                                              .map((e) => InfoStep
                                                                  .fromJson(
                                                                      e.data()))
                                                              .toList(),
                                                          date:
                                                              schedule["date"]);
                                                    } else {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }
                                                  });
                                            } else {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          });
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }))
                        ],
                      ),
                    ))),
              ),
            ],
          ),
        ));
  }
}
