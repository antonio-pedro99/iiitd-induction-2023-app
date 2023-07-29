import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/view/screens/schedule/day_schedule.dart';
import 'package:btech_induction_2023/view/screens/schedule/schedule_page.dart';
import 'package:btech_induction_2023/view/screens/schedule/tab_changer.dart';
import 'package:btech_induction_2023/view/widgets/headline.dart';
import 'package:btech_induction_2023/view/widgets/menu.dart';
import 'package:btech_induction_2023/view/widgets/menu_icon.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late var pageController;
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
                            onTap: () => context.pushReplacement(
                                  const InductionAppMenu(),
                                ),
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
                          child: PageView(
                        controller: pageController,
                        children: [
                          PageSchedule(
                              schedules: dayOneSchedule,
                              date: 'Wednesday, 2nd August'),
                          PageSchedule(
                              schedules: dayOneSchedule,
                              date: 'Thursday, 3rd August'),
                          PageSchedule(
                              schedules: dayOneSchedule,
                              date: 'Friday, 4th August'),
                        ],
                      ))
                    ],
                  ),
                ))),
          ),
        ],
      ),
    ));
  }
}
