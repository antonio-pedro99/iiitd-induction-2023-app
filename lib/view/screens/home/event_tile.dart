import 'package:btech_induction_2023/data/event.dart';
import 'package:btech_induction_2023/extensions/system.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  const EventTile({super.key, required this.event});

  final Event event;
  @override
  Widget build(BuildContext context) {
    return CascadeCard(
        child: Column(
      children: [
        Stack(
          children: [
            Container(
                width: 301,
                height: 180,
                decoration: ShapeDecoration(
                  color: InductionAppColor.red,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(66),
                        bottomRight: Radius.circular(9),
                        bottomLeft: Radius.circular(9)),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                        child: Image.asset(
                      "images/bg_texture.png",
                      repeat: ImageRepeat.repeat,
                    )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: (event.image == null || event.image!.isEmpty)
                          ? Image.asset("images/event_placeholder.png",
                              height: 170)
                          : Image.network(event.image!, height: 190),
                    ),
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      top: 110,
                      bottom: 12,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            event.title,
                            textWidthBasis: TextWidthBasis.longestLine,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Netflix Sans ',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.80,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Align(
                alignment: Alignment.topRight,
                child: InkResponse(
                  onTap: () => context.showSnackBar("Coming Soon!"),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: InductionAppColor.yellow,
                    child: const Icon(
                      Icons.alarm,
                      color: Colors.white,
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                child: Container(
                  width: context.width * .79,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: InductionAppColor.yellow,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 0.50, color: InductionAppColor.darkGrey),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          event.date,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Netflix Sans ',
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.80,
                          ),
                        ),
                      ),
                      Text(
                        event.time,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Netflix Sans',
                          fontWeight: FontWeight.w300,
                          letterSpacing: -0.48,
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 270,
          child: Text(
            event.description,
            textAlign: TextAlign.justify,
            softWrap: true,
            overflow: TextOverflow.fade,
            maxLines: 6,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Netflix Sans',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.56,
            ),
          ),
        )
      ],
    ));
  }
}
