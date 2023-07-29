import 'package:btech_induction_2023/data/event.dart';
import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/headline.dart';
import 'package:btech_induction_2023/view/widgets/menu.dart';
import 'package:btech_induction_2023/view/widgets/menu_icon.dart';
import 'package:btech_induction_2023/view/widgets/stepper.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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
                      const HeadlineText(text: "location"),
                      const SizedBox(height: 10),
                      Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: ShapeDecoration(
                                color: InductionAppColor.deepPurple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        width: 0.50,
                                        color: InductionAppColor.darkGrey)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Container(
                                    height: 200,
                                    decoration: ShapeDecoration(
                                      color: InductionAppColor.yellow,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              width: 0.50,
                                              color:
                                                  InductionAppColor.darkGrey)),
                                    ),
                                  )),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Get in touch',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Netflix Sans ',
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.46,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Expanded(
                                    child: InfoStepper(
                                      steps: [
                                        InfoStep(
                                          title: "Address",
                                          contents:
                                              "Okhla Industrial Estate, Phase III,\nOkhla Industrial Area, New Delhi,\nDelhi 110020",
                                        ),
                                        InfoStep(
                                          title: "Email",
                                          contents:
                                              "General information: info@iiitd.ac.in\n"
                                              "Placement: admin-placement@iiitd.ac.in"
                                              "Academic: admin-academic@iiitd.ac.in\n"
                                              "Website: admin-web@iiitd.ac.in\n"
                                              "Student verification: admin-btech@iiitd.ac.in",
                                        ),
                                        InfoStep(
                                            title: "Phone",
                                            contents: "+91-011-71985300"
                                                "+91-011-26907400-7404 (5 lines)"),
                                        InfoStep(
                                            title: "Directions to campus",
                                            contents:
                                                "To reach the campus, coming from Nehru\nPlace on outer ring road, follow these\ndirections:"
                                                "- After about half KM, turn Right from under\nthe first flyover (it is oneway)."
                                                "- After about 300 m, turn Left from under the\nGovind Puri Metro station (there\nis a IIITD sign at this turn)."
                                                "- After about 300 m, there will be a 'Y',\n take the left road of the 'Y'."
                                                "- Follow signs for IIIT-D - the main gate\nis after about 500 m.")
                                      ],
                                    ),
                                  )
                                ],
                              ))),
                    ],
                  ),
                ))),
          ),
        ],
      ),
    ));
  }
}
