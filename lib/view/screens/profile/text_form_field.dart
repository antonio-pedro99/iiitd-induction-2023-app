import 'package:flutter/material.dart';

class InductionAppTextFormField extends StatelessWidget {
  const InductionAppTextFormField(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.nameTextEditingController,
      this.enabled,
      required this.validationText});

  final TextEditingController nameTextEditingController;
  final String labelText;
  final String hintText;
  final String validationText;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameTextEditingController,
      textAlign: TextAlign.center,
      enabled: enabled,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationText;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: false,
        labelText: labelText,
        hintText: hintText,
        alignLabelWithHint: true,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Netflix Sans ',
          fontWeight: FontWeight.w700,
          letterSpacing: -0.64,
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF585858),
          fontSize: 24,
          fontFamily: 'Netflix Sans ',
          fontWeight: FontWeight.w700,
          letterSpacing: -0.96,
        ),
      ),
    );
  }
}
