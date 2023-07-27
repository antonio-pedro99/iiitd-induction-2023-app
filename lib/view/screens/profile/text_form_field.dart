import 'package:flutter/material.dart';

class InductionAppTextFormField extends StatelessWidget {
  const InductionAppTextFormField(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.nameTextEditingController,
      required this.validationText});

  final TextEditingController nameTextEditingController;
  final String labelText;
  final String hintText;
  final String validationText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameTextEditingController,
      textAlign: TextAlign.center,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationText;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        alignLabelWithHint: true,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white, // Set labelText color to white
        ),
        hintStyle: const TextStyle(
          color: Colors.white, // Set hintText color to white
        ),
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
