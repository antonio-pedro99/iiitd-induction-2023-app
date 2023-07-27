import 'package:flutter/material.dart';

class MenuButtonOption extends StatelessWidget {
  const MenuButtonOption(
      {super.key, required this.image, required this.margin, this.onTap});

  final String image;
  final EdgeInsetsGeometry margin;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(margin: margin, child: Image.asset('images/$image')),
    );
  }
}
