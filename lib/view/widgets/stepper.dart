import 'package:btech_induction_2023/extensions/system.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/constants.dart';
import 'package:flutter/material.dart';

class InfoStepper extends StatelessWidget {
  const InfoStepper(
      {super.key,
      required this.steps,
      this.leading = false,
      this.contentSpace = 2});
  final List<InfoStep> steps;
  final bool? leading;
  final double? contentSpace;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: steps.length,
            itemBuilder: ((context, index) {
              return FractionallySizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        leading!
                            ? Text(
                                steps[index].time!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Netflix Sans ',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.56,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: ShapeDecoration(
                        color: InductionAppColor.yellow,
                        shape: OvalBorder(
                          side: borderSide,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 7),
                        Text(
                          steps[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Netflix Sans ',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: context.width * 0.55,
                          child: Text(steps[index].contents,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Netflix Sans ',
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.46,
                              )),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
              );
            })),
        Positioned(
          left: leading! ? 68 : 16.6,
          top: 30,
          child: FractionallySizedBox(
            child: Container(
              width: 10,
              height: context.height,
              decoration: BoxDecoration(
                  color: InductionAppColor.yellow, shape: BoxShape.rectangle),
            ),
          ),
        )
      ],
    );
  }
}

class InfoStep {
  final String title;
  final String contents;
  final String? time;
  const InfoStep({required this.title, required this.contents, this.time});

  factory InfoStep.fromJson(Map<String, dynamic> json) {
    return InfoStep(
        title: json['title'], contents: json['contents'], time: json['time']);
  }
}
